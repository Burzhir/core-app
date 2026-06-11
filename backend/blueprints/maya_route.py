from flask import Blueprint, jsonify, request
from extensions import limiter
from services.maya_service import call_maya
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

    # --- Dummy Paywall Logic ---
    # In a real app, you'd check a database for their actual count and revenuecat status
    subscription_status = data.get("subscription_status", "free")
    message_count = data.get("message_count", 0) 

    if subscription_status != "premium" and message_count >= 10:
        return jsonify({
            "action": "paywall",
            "message": "You've reached your free limit for Maya. Upgrade to premium to continue getting deep, personalized insights.",
            "improvement": "Remember that the 12 core philosophies are always free. Take a moment to read through Stoicism or Taoism today.",
            "target": None
        })
    # ---------------------------

    result = call_maya(messages)
    return jsonify(result)
