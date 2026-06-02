from flask import Blueprint, request, jsonify
from extensions import limiter
from services.chat_service import chat as chat_service

chat_bp = Blueprint("chat", __name__)

@chat_bp.route("/api/chat", methods=["POST"])
@limiter.limit("20 per minute")
def chat():
    data = request.get_json(silent=True)
    if not data or "messages" not in data:
        return jsonify({"error": "Missing messages array"}), 400

    messages = data["messages"]
    if not isinstance(messages, list) or len(messages) == 0:
        return jsonify({"error": "Messages must be a non-empty array"}), 400

    response_text = chat_service(messages)
    return jsonify({"response": response_text})