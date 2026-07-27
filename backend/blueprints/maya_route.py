from flask import Blueprint, request, jsonify
from extensions import limiter
from services.maya_service import call_maya, check_paywall
from services.auth import verify_token, check_and_update_quota, increment_usage
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

    # Authentication
    token = data.get("token")
    if not token:
        return error_response("Authentication required", 401, "UNAUTHORIZED")

    user_info = verify_token(token)
    if user_info is None:
        return error_response("Invalid or expired token", 401, "UNAUTHORIZED")

    # Quota check
    allowed, remaining = check_and_update_quota(user_info)
    if not allowed:
        return error_response(
            "Daily AI message limit reached. Upgrade to continue.",
            429,
            "QUOTA_EXCEEDED"
        )

    # Use REAL premium status from Firestore, not client data
    is_premium = user_info.get("is_premium", False)
    paywall = check_paywall("premium" if is_premium else "free", remaining)
    if paywall:
        return jsonify(paywall)

    try:
        result = call_maya(messages)
    except Exception:
        return error_response("AI service temporarily unavailable", 500, "SERVER_ERROR")

    increment_usage(user_info)
    return jsonify(result)