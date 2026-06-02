# utils/text_cleaner.py
import unicodedata

def sanitize(text: str) -> str:
    """Remove control characters except newline and tab."""
    return "".join(
        c for c in text
        if not unicodedata.category(c).startswith("C") or c in "\n\t "
    )

def extract_text(data: dict) -> str:
    """Pull text from either 'text' field or 'answers' list."""
    if "text" in data:
        text = data["text"]
        if isinstance(text, str):
            return text
        return ""
    answers = data.get("answers", [])
    if isinstance(answers, list):
        return " ".join(str(a) for a in answers if isinstance(a, (str, int, float)))
    if isinstance(answers, str):
        return answers
    return ""