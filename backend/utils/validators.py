from functools import wraps
from flask import request
from .errors import error_response

def require_json(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if not request.is_json:
            return error_response("Content-Type must be application/json", 415)
        return f(*args, **kwargs)
    return wrapper