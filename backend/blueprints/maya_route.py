from flask import Blueprint, jsonify, request
from extensions import limiter
from services.maya_service import call_maya, check_paywall
from utils.errors import error_response
from utils.validators import require_json

maya_bp = Blueprint("maya", __name__)


@maya_bp.route("/api/maya", methods=["POST"])
@require_json
@limiter.limit("20 per minute")
def maya_chat():
    data = request.get_json()

    if "messages" not in data:
        return error_response("Missing 'messages' field", 400, "VALIDATION_ERROR")

    messages = data["messages"]
    if not isinstance(messages, list) or len(messages) == 0:
        return error_response("'messages' must be a non-empty array", 400, "VALIDATION_ERROR")

    subscription_status = data.get("subscription_status", "free")
    message_count = data.get("message_count", 0)

    # Paywall check is handled in the service layer
    paywall = check_paywall(subscription_status, message_count)
    if paywall:
        return jsonify(paywall)

    result = call_maya(messages)
    return jsonify(result)
