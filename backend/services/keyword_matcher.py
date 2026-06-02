def keyword_detect(text: str) -> dict:
    text_lower = sanitize(text).lower()

    # First pass: require minimum weight so weak single-word matches are skipped.
    # Multi-word keywords get higher weight (word count), making them rank higher.
    best_score = 0
    best_match = None
    best_keywords = []

    for entry in PHILOSOPHIES:
        matched = []
        for kw in entry["keywords"]:
            if re.search(rf"\b{re.escape(kw)}\b", text_lower):
                weight = len(kw.split())
                matched.append((kw, weight))

        total_weight = sum(w for _, w in matched)

        if total_weight < 2 and not any(w >= 3 for _, w in matched):
            continue

        if total_weight > best_score:
            best_score = total_weight
            best_match = entry
            best_keywords = [k for k, _ in matched]

    # Second pass: if the threshold above filtered everything out, retry without
    # it so we still return something meaningful instead of jumping to default.
    if not best_match:
        best_score = 0
        for entry in PHILOSOPHIES:
            matched = []
            for kw in entry["keywords"]:
                if re.search(rf"\b{re.escape(kw)}\b", text_lower):
                    weight = len(kw.split())
                    matched.append((kw, weight))
            total_weight = sum(w for _, w in matched)
            if total_weight > best_score:
                best_score = total_weight
                best_match = entry
                best_keywords = [k for k, _ in matched]

    if not best_match:
        return DEFAULT_RESPONSE

    confidence = (
        "high" if best_score >= 6 else
        "medium" if best_score >= 3 else
        "low"
    )

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