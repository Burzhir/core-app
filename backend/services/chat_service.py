import logging
from .ai_client import call_openrouter
from .fallbacks import CHAT_FALLBACK

logger = logging.getLogger(__name__)

FALLBACK_RESPONSE = CHAT_FALLBACK

_LANG_NOTE = " Always respond in English, regardless of what language the user writes in."


def _ensure_english(messages: list) -> list:
    """Append an English-language instruction to the first system message."""
    result = list(messages)
    for i, msg in enumerate(result):
        if msg.get("role") == "system":
            result[i] = {**msg, "content": msg["content"] + _LANG_NOTE}
            return result
    # No system message present — prepend a minimal one
    return [{"role": "system", "content": "You are a philosophical AI guide." + _LANG_NOTE}] + result


def chat(messages: list) -> str:
    """
    messages: list of dicts with 'role' and 'content'.
    The Flutter app sends the system prompt and conversation history.
    """
    try:
        result = call_openrouter(
            messages=_ensure_english(messages),
            temperature=0.7,
            max_tokens=400,
        )
        return result.get("content", FALLBACK_RESPONSE).strip()
    except Exception as exc:
        logger.warning("Chat AI failed: %s", exc)
        return FALLBACK_RESPONSE
