from flask import Blueprint, request, jsonify, g
from extensions import limiter
from services.diagnosis_service import detect_philosophy
from utils.text_cleaner import extract_text
from utils.errors import error_response
from utils.validators import require_json
import uuid, logging

logger = logging.getLogger(__name__)
diagnosis_bp = Blueprint("diagnosis", __name__)

@diagnosis_bp.before_request
def assign_request_id():
    g.req_id = str(uuid.uuid4())[:8]

@diagnosis_bp.route("/api/diagnose", methods=["POST"])
@require_json
@limiter.limit("30 per minute")
def diagnose():
    data = request.get_json()

    if not data:
        return error_response("Request body is empty", 400, "VALIDATION_ERROR")

    combined = extract_text(data).strip()
    if not combined:
        return error_response("No text or answers provided", 400, "VALIDATION_ERROR")
    if len(combined) > 2000:
        return error_response("Input too long (max 2000 characters)", 413, "PAYLOAD_TOO_LARGE")

    try:
        result = detect_philosophy(combined)
        return jsonify(result)
    except Exception as e:
        logger.error("req=%s error: %s", getattr(g, "req_id", "?"), e)
        return error_response("Internal server error", 500, "SERVER_ERROR")