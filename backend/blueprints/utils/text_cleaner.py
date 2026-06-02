def sanitize(text: str) -> str:
    return "".join(
        c for c in text
        if not unicodedata.category(c).startswith("C") or c in "\n\t "
    )

    def extract_text(data: dict) -> str:

    if "text" in data:
        text = data["text"]
        # FIX: Guard against non-string types in the "text" field
        if not isinstance(text, str):
            return ""
        return text

    answers = data.get("answers", [])

    if isinstance(answers, list):
        # FIX: Only join string/int/float items — skip dicts or other unexpected types
        return " ".join(
            str(a) for a in answers
            if a and isinstance(a, (str, int, float))
        )

    if isinstance(answers, str):
        return answers

    # FIX: Don't silently stringify unexpected types (e.g. dicts)
    return ""