from flask import Blueprint, jsonify, request
from extensions import limiter
from services.chat_service import chat as chat_service
from utils.errors import error_response
from utils.validators import require_json

chat_bp = Blueprint("chat", __name__)


@chat_bp.route("/api/chat", methods=["POST"])
@require_json                              # <-- validates Content-Type
@limiter.limit("20 per minute")
def chat():
    data = request.get_json()

    if "messages" not in data:
        return error_response("Missing 'messages' field", 400, "VALIDATION_ERROR")

    messages = data["messages"]
    if not isinstance(messages, list) or len(messages) == 0:
        return error_response("'messages' must be a non-empty array", 400, "VALIDATION_ERROR")

    try:
        reply = chat_service(messages)
        return jsonify({"response": reply})
    except Exception as e:
        # Chat service already has fallback, but if something truly unexpected happens:
        return error_response("Internal server error", 500, "SERVER_ERROR")