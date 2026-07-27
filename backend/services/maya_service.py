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
"""

def call_maya(messages: list) -> dict:
    formatted_messages = [{"role": "system", "content": MAYA_SYSTEM_PROMPT}]
    
    # Context trimming: keep only the last 6 messages to save cost
    recent_messages = messages[-6:] if len(messages) > 6 else messages
    for msg in recent_messages:
        if msg.get("role") != "system":
            formatted_messages.append(msg)

    api_key = current_app.config.get("OPENROUTER_API_KEY")

    headers = {
        "Authorization": f"Bearer {api_key}",
        "HTTP-Referer": current_app.config.get("APP_URL", "http://localhost:3000"),
        "Content-Type": "application/json"
    }

    payload = {
        "model": "deepseek/deepseek-v4-flash",
        "messages": formatted_messages,
        "temperature": 0.6,
        "response_format": {"type": "json_object"}
    }

    try:
        resp = requests.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers=headers,
            json=payload,
            timeout=15
        )
        resp.raise_for_status()
        data = resp.json()
        raw_content = data["choices"][0]["message"]["content"].strip()
        
        parsed = json.loads(raw_content)
        return {
            "action": parsed.get("action", "chat"),
            "message": parsed.get("message", "I'm here. How can I help?"),
            "improvement": parsed.get("improvement"),
            "target": parsed.get("target"),
        }
    except Exception as exc:
        logger.error("Maya API failed: %s", exc)
        return {
            "action": "chat",
            "message": "I'm having a bit of trouble connecting to my core logic right now. Please try again in a moment.",
            "improvement": None,
            "target": None,
        }
