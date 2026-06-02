from .ai_client import ask_openrouter
from .keyword_matcher import keyword_detect
from data import PHILOSOPHIES
import logging

logger = logging.getLogger(__name__)

def detect_philosophy(text: str) -> dict:
    try:
        # Build system prompt as before (same as your current app.py)
        philosophy_names = [p["philosophy"] for p in PHILOSOPHIES]
        system_prompt = (
            "You are a philosophical diagnostician.\n\n"
            "Analyze the user's emotional state and choose ONLY ONE philosophy from the list.\n\n"
            + "\n".join(f"- {name}" for name in philosophy_names) + "\n\n"
            "Return ONLY valid JSON.\n\n"
            'Schema:\n{"philosophy": "EXACT name", "reason": "short advice under 80 words"}\n\n'
            "No markdown. JSON only."
        )
        result = ask_openrouter(text, system_prompt, json_mode=True)
        # Match with metadata
        matched = next((p for p in PHILOSOPHIES if p["philosophy"] == result.get("philosophy")), None)
        return {
            "philosophy": result["philosophy"],
            "color": matched["color"] if matched else "#FF9500",
            "icon": matched["icon"] if matched else "⚡",
            "reason": result["reason"],
            "matched_keywords": [],
            "score": 0,
            "source": "openrouter",
            "confidence": "medium",
        }
    except Exception as exc:
        logger.warning("OpenRouter failed (%s), fallback to keywords", exc)
        return keyword_detect(text)