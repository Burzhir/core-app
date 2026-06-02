from .ai_client import ask_openrouter
import logging

logger = logging.getLogger(__name__)

DEFAULT_FALLBACK = "I'm here. What would you like to explore?"

def chat(messages: list) -> str:
    """
    messages: list of dicts with 'role' and 'content'.
    The client already includes the system prompt, so we pass all messages directly.
    """
    try:
        # We'll use a generic system prompt if none provided, but the client sends the full conversation.
        # So we just forward the messages array to OpenRouter.
        result = ask_openrouter(
            text="",  # not used when messages are provided
            system_prompt="",  # we'll override in the API call
            temperature=0.7,
            max_tokens=400,
            json_mode=False,
            messages=messages  # we'll modify ask_openrouter to accept an optional messages param
        )
        return result.get("raw_response", DEFAULT_FALLBACK)
    except Exception as exc:
        logger.warning("Chat AI failed: %s", exc)
        return DEFAULT_FALLBACK