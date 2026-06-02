from flask import Blueprint, request, jsonify
from extensions import limiter
from services.analyze_service import analyze_journal
from utils.errors import error_response
from utils.validators import require_json

analyze_bp = Blueprint("analyze", __name__)

@analyze_bp.route("/api/analyze", methods=["POST"])
@require_json
@limiter.limit("10 per minute")
def analyze():
    data = request.get_json()

    if "text" not in data:
        return error_response("Missing 'text' field", 400, "VALIDATION_ERROR")

    text = data["text"]
    if not isinstance(text, str) or len(text.strip()) == 0:
        return error_response("Journal text must be a non-empty string", 400, "VALIDATION_ERROR")

    user_name = data.get("userName", "User")
    result = analyze_journal(text.strip(), user_name)
    return jsonify(result)