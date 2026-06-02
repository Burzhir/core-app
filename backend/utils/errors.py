from flask import jsonify, g

def error_response(message: str, status_code: int = 400, error_code: str | None = None):
    """
    Return a uniform JSON error response.
    Always includes:
      - error: human‑readable message
      - req_id: the request ID (for debugging)
    Can optionally include:
      - code: a machine‑readable error code (e.g. "VALIDATION_ERROR", "RATE_LIMITED")
    """
    payload = {
        "error": message,
        "req_id": getattr(g, "req_id", "unknown"),
    }
    if error_code:
        payload["code"] = error_code

    return jsonify(payload), status_code