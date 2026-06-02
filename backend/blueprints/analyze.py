from flask import Blueprint, request, jsonify
from extensions import limiter
from services.analyze_service import analyze_journal

analyze_bp = Blueprint("analyze", __name__)

@analyze_bp.route("/api/analyze", methods=["POST"])
@limiter.limit("10 per minute")
def analyze():
    data = request.get_json(silent=True)
    if not data or "text" not in data:
        return jsonify({"error": "Missing 'text' field"}), 400

    text = data["text"]
    if not isinstance(text, str) or len(text.strip()) == 0:
        return jsonify({"error": "Journal text is empty"}), 400

    user_name = data.get("userName", "User")
    result = analyze_journal(text.strip(), user_name)
    return jsonify(result)