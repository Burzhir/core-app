# data/__init__.py
import json
import os

_data_file = os.path.join(os.path.dirname(__file__), "philosophies.json")
with open(_data_file, "r", encoding="utf-8") as f:
    PHILOSOPHIES = json.load(f)