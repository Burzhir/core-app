import logging
import json
import re
from .ai_client import call_openrouter
from .keyword_matcher import keyword_detect
from data import PHILOSOPHIES

logger = logging.getLogger(__name__)

def _extract_json(text: str) -> dict:
    """Try to parse a JSON object from a string, even if embedded."""
    # Strip markdown code fences
    text = text.strip()
    if text.startswith("```"):
        text = text.replace("```json", "").replace("```", "").strip()
    # Find JSON object
    match = re.search(r"\{.*\}", text, re.DOTALL)
    if match:
        return json.loads(match.group())
    raise ValueError("No JSON object found")

def detect_philosophy(text: str) -> dict:
    philosophy_names = [p["philosophy"] for p in PHILOSOPHIES]
    system_prompt = (
        "You are a philosophical diagnostician.\n\n"
        "Analyze the user's emotional state and choose ONLY ONE philosophy from the list.\n\n"
        + "\n".join(f"- {name}" for name in philosophy_names) + "\n\n"
        "Return ONLY a valid JSON object (no markdown, no extra text):\n"
        '{"philosophy": "EXACT name", "reason": "short advice under 80 words"}'
    )

    try:
        result = call_openrouter(
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": text},
            ],
            temperature=0.6,
            max_tokens=300,
            # json_mode removed
        )
        raw = result.get("content", "")
        parsed = _extract_json(raw)

        matched = next((p for p in PHILOSOPHIES if p["philosophy"] == parsed.get("philosophy")), None)
        return {
            "philosophy": parsed.get("philosophy", "Forge Yourself"),
            "color": matched["color"] if matched else "#FF9500",
            "icon": matched["icon"] if matched else "⚡",
            "reason": parsed.get("reason", ""),
            "matched_keywords": [],
            "score": 0,
            "source": "openrouter",
            "confidence": "medium",
        }
    except Exception as exc:
        logger.warning("AI diagnosis failed (%s), falling back to keywords", exc)
        return keyword_detect(text)