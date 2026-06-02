from flask import Blueprint, jsonify
from data import PHILOSOPHIES

philosophies_bp = Blueprint("philosophies", __name__)

@philosophies_bp.route("/api/philosophies")
def list_philosophies():
    slim = [{"id": p["id"], "philosophy": p["philosophy"], "color": p["color"], "icon": p["icon"]} for p in PHILOSOPHIES]
    return jsonify({"philosophies": slim, "count": len(slim)})