from flask import Blueprint, request, jsonify
from extensions import limiter
from services.diagnosis_service import detect_philosophy
from utils.text_cleaner import extract_text, sanitize  # we'll move those helpers

diagnosis_bp = Blueprint("diagnosis", __name__)

@diagnosis_bp.route("/api/diagnose", methods=["POST"])
@limiter.limit("30 per minute")
def diagnose():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Request body must be valid JSON."}), 400

    combined_text = extract_text(data).strip()
    if not combined_text:
        return jsonify({"error": "No input provided."}), 400
    if len(combined_text) > 2000:
        return jsonify({"error": "Input too long. Max 2000 characters."}), 413

    try:
        result = detect_philosophy(combined_text)
        return jsonify(result), 200
    except Exception as exc:
        logger.error("req=%s Unhandled error: %s", g.req_id, exc)
        return jsonify({"error": "Something went wrong."}), 500