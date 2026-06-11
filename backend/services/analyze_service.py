import logging
import json
import re
from .ai_client import call_openrouter
from .fallbacks import DEFAULT_ANALYSIS
from .keyword_matcher import keyword_detect

logger = logging.getLogger(__name__)

def _extract_json(text: str) -> dict:
    text = text.strip()
    if text.startswith("```"):
        text = text.replace("```json", "").replace("```", "").strip()
    match = re.search(r"\{.*\}", text, re.DOTALL)
    if match:
        return json.loads(match.group())
    raise ValueError("No JSON object found")

def analyze_journal(text: str, user_name: str) -> dict:
    # 1. Fast, free keyword detection to save Maya tokens
    kw_result = keyword_detect(text)
    if kw_result["confidence"] == "high":
        logger.info(f"Skipping AI, using high-confidence keyword match: {kw_result['philosophy']}")
        keywords = kw_result.get("matched_keywords", [])
        return {
            "themes": keywords[:3],
            "emotionalTone": "introspective",
            "recurringPattern": f"Recurring focus on {keywords[0]}." if keywords else "Exploring core values.",
            "insight": f"Your thoughts naturally align with {kw_result['philosophy']} principles right now.",
            "philosophyMatch": kw_result["philosophy"],
            "suggestedAction": kw_result["reason"],
        }

    # 2. If confidence is low/medium, use the AI for a deep analysis
    system_prompt = (
        "You are a journal analyst. Analyze the following journal entry and return ONLY a valid JSON object "
        "(no markdown, no extra text).\n\n"
        "JSON Schema:\n"
        "{\n"
        '  "themes": ["theme1", "theme2"],\n'
        '  "emotionalTone": "overall tone (e.g., anxious, hopeful)",\n'
        '  "recurringPattern": "any pattern you notice",\n'
        '  "insight": "one deep insight",\n'
        '  "philosophyMatch": "one philosophy that could help from: Stoicism, Existentialism, Absurdism, Nihilism, Taoism, Humanism, Pragmatism, Epicureanism, Buddhism, Virtue Ethics, Rationalism, Cynicism",\n'
        '  "suggestedAction": "concrete action step"\n'
        "}"
    )

    try:
        result = call_openrouter(
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": f"User: {user_name}\nEntry: {text}"},
            ],
            temperature=0.5,
            max_tokens=300,
        )
        raw = result.get("content", "")
        parsed = _extract_json(raw)

        return {
            "themes": parsed.get("themes", []) or [],
            "emotionalTone": parsed.get("emotionalTone", "neutral"),
            "recurringPattern": parsed.get("recurringPattern", ""),
            "insight": parsed.get("insight", ""),
            "philosophyMatch": parsed.get("philosophyMatch", "Stoicism"),
            "suggestedAction": parsed.get("suggestedAction", ""),
        }
    except Exception as exc:
        logger.warning("Analyze AI failed: %s", exc)
        return DEFAULT_ANALYSIS