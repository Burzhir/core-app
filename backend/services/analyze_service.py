from .ai_client import ask_openrouter
import logging

logger = logging.getLogger(__name__)

DEFAULT_ANALYSIS = {
    "themes": [],
    "emotionalTone": "neutral",
    "recurringPattern": "",
    "insight": "No analysis available at this moment.",
    "philosophyMatch": "Stoicism",
    "suggestedAction": "Write again tomorrow.",
}

def analyze_journal(text: str, user_name: str) -> dict:
    system_prompt = (
        "You are a journal analyst. Analyze the following journal entry and return ONLY valid JSON.\n"
        "Schema:\n"
        "{\n"
        '  "themes": ["theme1", "theme2"],\n'
        '  "emotionalTone": "overall tone (e.g., anxious, hopeful)",\n'
        '  "recurringPattern": "any pattern you notice",\n'
        '  "insight": "one deep insight",\n'
        '  "philosophyMatch": "one philosophy that could help from this list: Stoicism, Existentialism, Absurdism, Nihilism, Taoism, Humanism, Pragmatism, Epicureanism, Buddhism, Virtue Ethics, Rationalism, Cynicism",\n'
        '  "suggestedAction": "concrete action step"\n'
        "}\n"
        "No markdown. JSON only."
    )
    try:
        result = ask_openrouter(
            text=f"User: {user_name}\nEntry: {text}",
            system_prompt=system_prompt,
            json_mode=True,
            temperature=0.5,
            max_tokens=300,
        )
        # Validate and fill defaults
        return {
            "themes": result.get("themes", []) or [],
            "emotionalTone": result.get("emotionalTone", "neutral"),
            "recurringPattern": result.get("recurringPattern", ""),
            "insight": result.get("insight", ""),
            "philosophyMatch": result.get("philosophyMatch", "Stoicism"),
            "suggestedAction": result.get("suggestedAction", ""),
        }
    except Exception as exc:
        logger.warning("Analyze AI failed: %s", exc)
        return DEFAULT_ANALYSIS