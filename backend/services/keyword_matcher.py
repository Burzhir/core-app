# services/keyword_matcher.py
import re
from data import PHILOSOPHIES
from utils.text_cleaner import sanitize

DEFAULT_RESPONSE = {
    "philosophy": "Forge Yourself",
    "color": "#FF9500",
    "icon": "⚒️",
    "reason": "No strong pattern detected. Stop overthinking and take direct action.",
    "matched_keywords": [],
    "score": 0,
    "source": "default",
    "confidence": "low",
}


def _score_entry(entry: dict, text_lower: str) -> list[tuple[str, int]]:
    """Return a list of (keyword, weight) tuples matched in text_lower for one philosophy entry."""
    matched = []
    for kw in entry["keywords"]:
        if re.search(rf"\b{re.escape(kw)}\b", text_lower):
            weight = len(kw.split())
            matched.append((kw, weight))
    return matched


def keyword_detect(text: str) -> dict:
    text_lower = sanitize(text).lower()
    best_score = 0
    best_match = None
    best_keywords: list[str] = []

    # First pass: require some minimum weight to avoid noise
    for entry in PHILOSOPHIES:
        matched = _score_entry(entry, text_lower)
        total_weight = sum(w for _, w in matched)
        if total_weight < 2 and not any(w >= 3 for _, w in matched):
            continue
        if total_weight > best_score:
            best_score = total_weight
            best_match = entry
            best_keywords = [k for k, _ in matched]

    # Second pass: no threshold, so we avoid returning the default too early
    if not best_match:
        for entry in PHILOSOPHIES:
            matched = _score_entry(entry, text_lower)
            total_weight = sum(w for _, w in matched)
            if total_weight > best_score:
                best_score = total_weight
                best_match = entry
                best_keywords = [k for k, _ in matched]

    if not best_match:
        return DEFAULT_RESPONSE

    confidence = "high" if best_score >= 6 else "medium" if best_score >= 3 else "low"
    return {
        "philosophy": best_match["philosophy"],
        "color": best_match["color"],
        "icon": best_match["icon"],
        "reason": best_match["reason"],
        "matched_keywords": best_keywords,
        "score": best_score,
        "source": "keywords",
        "confidence": confidence,
    }
