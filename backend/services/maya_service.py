import os
import json
import requests
import logging
from flask import current_app

logger = logging.getLogger(__name__)

MAYA_SYSTEM_PROMPT = """You are Maya, the central Operating System and empathetic companion guide of the CORE app.
Your main job is to support the user while prioritizing the 12 core philosophies. You are not the main point of the app; the philosophies and journaling are.

CRITICAL REQUIREMENT:
You MUST respond EXCLUSIVELY in valid JSON format matching this schema:
{
  "action": "chat" | "navigate",
  "message": "Your main response. Speak empathetically, wisely, and concisely.",
  "improvement": "A separate paragraph providing a concrete action step or actionable advice on how they can improve themselves.",
  "target": "today" | "forge" | "library" | "journal" | "profile" | "philosophy_detail" | null
}

Guidelines:
1. Direct users to the 12 free philosophies for deep wisdom.
2. You can draw from sub-philosophies or "isms" that promote growth (e.g., Optimistic Existentialism), but reference them naturally and guide the user back to the closest main philosophy in the library.
3. Encourage users to use the journal, complete daily challenges, and keep streaks.
4. "navigate" action: use to send user to a specific part. Set "target" appropriately.
5. ALWAYS respond in English, regardless of the language the user writes in.
"""


def check_paywall(subscription_status: str, message_count: int) -> dict | None:
    """Return a paywall response dict if the free limit is reached, else None."""
    if subscription_status != "premium" and message_count >= 10:
        return {
            "action": "paywall",
            "message": "You've reached your free limit for Maya. Upgrade to premium to continue getting deep, personalized insights.",
            "improvement": "Remember that the 12 core philosophies are always free. Take a moment to read through Stoicism or Taoism today.",
            "target": None,
        }
    return None


def call_maya(messages: list) -> dict:
    formatted_messages = [{"role": "system", "content": MAYA_SYSTEM_PROMPT}]

    # Context trimming: keep only the last 6 messages to save cost
    recent_messages = messages[-6:] if len(messages) > 6 else messages
    for msg in recent_messages:
        if msg.get("role") != "system":
            formatted_messages.append(msg)

    api_key = os.getenv("OPENROUTER_API_KEY")
    if not api_key and current_app:
        api_key = current_app.config.get("OPENROUTER_API_KEY")

    if not api_key:
        logger.error("Maya: OPENROUTER_API_KEY is not set")
        return _fallback()

    app_url = current_app.config.get("APP_URL", "http://localhost:3000") if current_app else "http://localhost:3000"

    headers = {
        "Authorization": f"Bearer {api_key}",
        "HTTP-Referer": app_url,
        "Content-Type": "application/json",
    }

    payload = {
        "model": "deepseek/deepseek-v4-flash",
        "messages": formatted_messages,
        "temperature": 0.6,
        "response_format": {"type": "json_object"},
    }

    try:
        resp = requests.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers=headers,
            json=payload,
            timeout=15,
        )
        resp.raise_for_status()
        data = resp.json()

        # Defensive access — validate structure before indexing
        choices = data.get("choices")
        if not isinstance(choices, list) or len(choices) == 0:
            logger.error("Maya: unexpected response structure: %s", data)
            return _fallback()

        raw_content = choices[0].get("message", {}).get("content", "").strip()
        if not raw_content:
            logger.error("Maya: empty content in response")
            return _fallback()

        try:
            parsed = json.loads(raw_content)
        except json.JSONDecodeError as e:
            logger.error("Maya: JSON decode failed: %s — raw: %s", e, raw_content[:200])
            return _fallback()

        return {
            "action": parsed.get("action", "chat"),
            "message": parsed.get("message", "I'm here. How can I help?"),
            "improvement": parsed.get("improvement"),
            "target": parsed.get("target"),
        }

    except Exception as exc:
        logger.error("Maya API failed: %s", exc)
        return _fallback()


def _fallback() -> dict:
    return {
        "action": "chat",
        "message": "I'm having a bit of trouble connecting right now. Please try again in a moment.",
        "improvement": None,
        "target": None,
    }
