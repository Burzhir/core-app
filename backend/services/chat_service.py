
import logging
from .ai_client import call_openrouter
from .fallbacks import CHAT_FALLBACK

logger = logging.getLogger(__name__)

FALLBACK_RESPONSE = CHAT_FALLBACK

def chat(messages: list) -> str:
    """
    messages: list of dicts with 'role' and 'content'.
    The Flutter app sends the system prompt and conversation history.
    """
    try:
        result = call_openrouter(
            messages=messages,
            temperature=0.7,
            max_tokens=400,
        )
        return result.get("content", FALLBACK_RESPONSE).strip()
    except Exception as exc:
        logger.warning("Chat AI failed: %s", exc)
        return FALLBACK_RESPONSE