import os
import re
import json
import uuid
import unicodedata
import logging

from dotenv import load_dotenv
from flask import Flask, jsonify, request, g
from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

import requests

load_dotenv()

# ──────────────────────────────────────────────────────────────────────────────
# Logging
# ──────────────────────────────────────────────────────────────────────────────

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

logger = logging.getLogger(__name__)

# ──────────────────────────────────────────────────────────────────────────────
# Flask App
# ──────────────────────────────────────────────────────────────────────────────

app = Flask(__name__)
CORS(app)

storage_uri = os.getenv("REDIS_URL", "memory://")

limiter = Limiter(
    key_func=get_remote_address,
    app=app,
    default_limits=["200 per day", "50 per hour"],
    storage_uri=storage_uri,
)

MAX_INPUT_LENGTH = 2000

# ──────────────────────────────────────────────────────────────────────────────
# OpenRouter
# ──────────────────────────────────────────────────────────────────────────────

OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"


def get_openrouter_key():
    return os.getenv("OPENROUTER_API_KEY")


# ──────────────────────────────────────────────────────────────────────────────
# Philosophies
# ──────────────────────────────────────────────────────────────────────────────

PHILOSOPHIES = [
    {
        "id": "stoicism",
        "philosophy": "Stoicism",
        "color": "#D4AF37",
        "icon": "🏛️",
        "keywords": [
            "control",
            "can't change",
            "accept",
            "stress",
            "anxiety",
            "overwhelm",
            "calm",
            "resilience",
            "outside my control",
            "let go",
        ],
        "reason": (
            "Separate what you can control from what you can't. "
            "Put your energy only into action, not panic."
        ),
    },
    {
        "id": "existentialism",
        "philosophy": "Existentialism",
        "color": "#7F8C8D",
        "icon": "🎭",
        "keywords": [
            "meaning",
            "purpose",
            "lost",
            "direction",
            "why am i here",
            "freedom",
            "choice",
            "my life is pointless",
        ],
        "reason": (
            "You are not born with purpose. You build it through choices. "
            "Take one meaningful action today instead of waiting for clarity."
        ),
    },
    {
        "id": "nihilism",
        "philosophy": "Nihilism",
        "color": "#2C3E50",
        "icon": "🕳️",
        "keywords": [
            "nothing matters",
            "empty",
            "why bother",
            "everything is pointless",
            "life is meaningless",
            "apathy",
        ],
        "reason": (
            "If nothing has inherent meaning, you're free to create your own. "
            "Use that freedom instead of surrendering to paralysis."
        ),
    },
    {
        "id": "absurdism",
        "philosophy": "Absurdism",
        "color": "#BF5AF2",
        "icon": "🎪",
        "keywords": [
            "absurd",
            "life is a joke",
            "nothing makes sense",
            "random",
            "chaos",
        ],
        "reason": (
            "The universe owes you no explanation. "
            "Laugh at the absurdity and keep moving anyway."
        ),
    },
    {
        "id": "humanism",
        "philosophy": "Humanism",
        "color": "#4A90D9",
        "icon": "🤝",
        "keywords": [
            "compassion",
            "empathy",
            "kindness",
            "human rights",
            "community",
            "help others",
        ],
        "reason": (
            "Human connection matters. "
            "Use reason and compassion together instead of cynicism."
        ),
    },
    {
        "id": "fatalism",
        "philosophy": "Fatalism",
        "color": "#8E44AD",
        "icon": "🕸️",
        "keywords": [
            "fate",
            "destiny",
            "predetermined",
            "inevitable",
            "what will be will be",
        ],
        "reason": (
            "Stop exhausting yourself trying to dominate every outcome. "
            "Focus on the present moment instead."
        ),
    },
    {
        "id": "individualism",
        "philosophy": "Individualism",
        "color": "#E91E63",
        "icon": "🧍",
        "keywords": [
            "independence",
            "my own path",
            "autonomy",
            "be yourself",
            "nonconformity",
        ],
        "reason": (
            "Your life is yours. "
            "Make decisions based on your values, not external approval."
        ),
    },
    {
        "id": "collectivism",
        "philosophy": "Collectivism",
        "color": "#2ECC71",
        "icon": "🤲",
        "keywords": [
            "community",
            "together",
            "solidarity",
            "team",
            "common good",
        ],
        "reason": (
            "Humans survive through cooperation. "
            "Strength grows through meaningful connection."
        ),
    },
    {
        "id": "minimalism",
        "philosophy": "Minimalism",
        "color": "#A5D6A7",
        "icon": "🪴",
        "keywords": [
            "declutter",
            "simplify",
            "too much stuff",
            "simple living",
        ],
        "reason": (
            "Remove excess. "
            "Clarity appears when distraction disappears."
        ),
    },
    {
        "id": "hedonism",
        "philosophy": "Hedonism",
        "color": "#FFC107",
        "icon": "🍇",
        "keywords": [
            "pleasure",
            "enjoyment",
            "fun",
            "joy",
            "happy",
        ],
        "reason": (
            "Pleasure is not automatically weakness. "
            "Allow yourself moments of genuine enjoyment."
        ),
    },
    {
        "id": "asceticism",
        "philosophy": "Asceticism",
        "color": "#8D6E63",
        "icon": "🧘",
        "keywords": [
            "discipline",
            "self denial",
            "sacrifice comfort",
            "fasting",
            "monk mode",
        ],
        "reason": (
            "Voluntary discomfort builds discipline. "
            "Master your impulses instead of obeying them."
        ),
    },
    {
        "id": "pragmatism",
        "philosophy": "Pragmatism",
        "color": "#607D8B",
        "icon": "🔧",
        "keywords": [
            "practical",
            "solution",
            "fix it",
            "results",
            "effective",
        ],
        "reason": (
            "Focus on what works in reality, not what sounds impressive."
        ),
    },
    {
        "id": "optimism",
        "philosophy": "Optimism",
        "color": "#FFEB3B",
        "icon": "🌞",
        "keywords": [
            "hope",
            "bright side",
            "positive",
            "better future",
        ],
        "reason": (
            "Your expectations shape your actions. "
            "Train yourself to look for possibility instead of defeat."
        ),
    },
    {
        "id": "pessimism",
        "philosophy": "Pessimism",
        "color": "#37474F",
        "icon": "🌧️",
        "keywords": [
            "worst case",
            "negative",
            "suffering",
            "disappointment",
        ],
        "reason": (
            "Prepare for difficulty realistically, but don't worship misery."
        ),
    },
    {
        "id": "cynicism",
        "philosophy": "Cynicism",
        "color": "#66BB6A",
        "icon": "🐕",
        "keywords": [
            "skeptical",
            "fake",
            "hypocrisy",
            "don't trust",
            "liars",
        ],
        "reason": (
            "Question systems and appearances, but don't let bitterness rot you."
        ),
    },
    {
        "id": "romanticism",
        "philosophy": "Romanticism",
        "color": "#E91E63",
        "icon": "🌹",
        "keywords": [
            "emotion",
            "passion",
            "beauty",
            "love",
            "heart over head",
        ],
        "reason": (
            "Emotion and imagination matter. "
            "Not everything valuable can be measured logically."
        ),
    },
    {
        "id": "realism",
        "philosophy": "Realism",
        "color": "#607D8B",
        "icon": "👁️",
        "keywords": [
            "facts",
            "truth",
            "objective",
            "reality",
            "honest",
        ],
        "reason": (
            "See situations as they actually are, not as you wish they were."
        ),
    },
    {
        "id": "buddhism",
        "philosophy": "Buddhism",
        "color": "#FFA726",
        "icon": "☸️",
        "keywords": [
            "mindfulness",
            "meditate",
            "attachment",
            "impermanence",
            "peace within",
        ],
        "reason": (
            "Suffering grows through attachment. "
            "Practice awareness instead of clinging."
        ),
    },
    {
        "id": "taoism",
        "philosophy": "Taoism",
        "color": "#66BB6A",
        "icon": "☯️",
        "keywords": [
            "flow",
            "balance",
            "go with the flow",
            "wu wei",
        ],
        "reason": (
            "Stop forcing everything. "
            "Some strength comes through flexibility."
        ),
    },
    {
        "id": "confucianism",
        "philosophy": "Confucianism",
        "color": "#D32F2F",
        "icon": "📜",
        "keywords": [
            "respect",
            "tradition",
            "family",
            "virtue",
            "duty",
        ],
        "reason": (
            "Character and discipline create stability. "
            "Build yourself before trying to fix the world."
        ),
    },
]

DEFAULT_RESPONSE = {
    "philosophy": "Forge Yourself",
    "color": "#FF9500",
    "icon": "⚒️",
    "reason": (
        "No strong pattern detected. "
        "Stop overthinking and take direct action."
    ),
    "matched_keywords": [],
    "score": 0,
    "source": "default",
    "confidence": "low",
}

# ──────────────────────────────────────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────────────────────────────────────

def sanitize(text: str) -> str:
    return "".join(
        c for c in text
        if not unicodedata.category(c).startswith("C") or c in "\n\t "
    )

def keyword_detect(text: str) -> dict:
    text_lower = sanitize(text).lower()

    # First pass: require minimum weight
    best_score = 0
    best_match = None
    best_keywords = []

    for entry in PHILOSOPHIES:
        matched = []
        for kw in entry["keywords"]:
            if re.search(rf"\b{re.escape(kw)}\b", text_lower):
                weight = len(kw.split())
                matched.append((kw, weight))

        total_weight = sum(w for _, w in matched)

        if total_weight < 2 and not any(w >= 3 for _, w in matched):
            continue

        if total_weight > best_score:
            best_score = total_weight
            best_match = entry
            best_keywords = [k for k, _ in matched]

    # If still no match, try without the threshold (fallback within fallback)
    if not best_match:
        best_score = 0
        for entry in PHILOSOPHIES:
            matched = []
            for kw in entry["keywords"]:
                if re.search(rf"\b{re.escape(kw)}\b", text_lower):
                    weight = len(kw.split())
                    matched.append((kw, weight))
            total_weight = sum(w for _, w in matched)
            if total_weight > best_score:
                best_score = total_weight
                best_match = entry
                best_keywords = [k for k, _ in matched]

    if not best_match:
        return DEFAULT_RESPONSE

    confidence = (
        "high" if best_score >= 6 else
        "medium" if best_score >= 3 else
        "low"
    )

    return {
        "philosophy": best_match["philosophy"],
        "color": best_match["color"],
        "icon": best_match["icon"],
        "reason": best_match["reason"],
        "matched_keywords": best_keywords,
        "score": best_score,
        "source": "keywords",
        "confidence": confidence,
    }


def ask_openrouter(text: str) -> dict:

    api_key = get_openrouter_key()

    if not api_key:
        raise ValueError("OPENROUTER_API_KEY missing")

    philosophy_names = [p["philosophy"] for p in PHILOSOPHIES]

    philosophy_list = "\n".join(
        f"- {name}" for name in philosophy_names
    )

    system_prompt = (
        "You are a philosophical diagnostician.\n\n"
        "Analyze the user's emotional state and choose ONLY ONE philosophy "
        "from the list.\n\n"
        f"{philosophy_list}\n\n"
        "Return ONLY valid JSON.\n\n"
        "Schema:\n"
        "{\n"
        '  "philosophy": "EXACT philosophy name",\n'
        '  "reason": "Short direct advice under 80 words"\n'
        "}\n\n"
        "No markdown.\n"
        "No explanations.\n"
        "JSON only."
    )

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": "http://localhost:3000",
        "X-Title": "Philosophy Diagnostician",
    }

    payload = {
        "model": "openrouter/free",
        "messages": [
            {
                "role": "system",
                "content": system_prompt,
            },
            {
                "role": "user",
                "content": sanitize(text),
            },
        ],
        "temperature": 0.6,
        "max_tokens": 180,
        "response_format": {
            "type": "json_object"
        },
        "provider": {
            "allow_fallbacks": True
        }
    }

    response = requests.post(
        OPENROUTER_URL,
        headers=headers,
        json=payload,
        timeout=45,
    )

    if response.status_code != 200:
        raise Exception(
            f"OpenRouter Error {response.status_code}: {response.text}"
        )

    data = response.json()

    raw = data["choices"][0]["message"]["content"].strip()

    # Remove accidental markdown
    if raw.startswith("```"):
        raw = raw.replace("```json", "")
        raw = raw.replace("```", "")
        raw = raw.strip()

    # Safe JSON extraction
    try:
        parsed = json.loads(raw)

    except json.JSONDecodeError:

        match = re.search(r"\{.*\}", raw, re.DOTALL)

        if not match:
            raise ValueError(f"Invalid JSON from model: {raw}")

        parsed = json.loads(match.group())

    if "philosophy" not in parsed:
        raise ValueError("Missing philosophy field")

    if "reason" not in parsed:
        raise ValueError("Missing reason field")

    matched_meta = next(
        (
            p for p in PHILOSOPHIES
            if p["philosophy"] == parsed["philosophy"]
        ),
        None,
    )

    return {
        "philosophy": parsed["philosophy"],
        "color": matched_meta["color"] if matched_meta else "#FF9500",
        "icon": matched_meta["icon"] if matched_meta else "⚡",
        "reason": parsed["reason"],
        "matched_keywords": [],
        "score": 0,
        "source": "openrouter",
        "confidence": "high",
    }


def detect_philosophy(text: str) -> dict:

    req_id = getattr(g, "req_id", "?")

    try:

        result = ask_openrouter(text)

        logger.info(
            "req=%s source=openrouter philosophy=%s",
            req_id,
            result["philosophy"],
        )

        return result

    except Exception as exc:

        logger.warning(
            "req=%s OpenRouter failed (%s), using keyword fallback",
            req_id,
            exc,
        )

        result = keyword_detect(text)

        logger.info(
            "req=%s source=keywords philosophy=%s score=%s",
            req_id,
            result["philosophy"],
            result["score"],
        )

        return result


def extract_text(data: dict) -> str:

    if "text" in data:
        return str(data["text"])

    answers = data.get("answers", [])

    if isinstance(answers, list):
        return " ".join(str(a) for a in answers if a)

    return str(answers)


# ──────────────────────────────────────────────────────────────────────────────
# Request Hooks
# ──────────────────────────────────────────────────────────────────────────────

@app.before_request
def assign_request_id():
    g.req_id = str(uuid.uuid4())[:8]


# ──────────────────────────────────────────────────────────────────────────────
# Routes
# ──────────────────────────────────────────────────────────────────────────────

@app.route("/api/diagnose", methods=["POST"])
@limiter.limit("30 per minute")
def diagnose():

    data = request.get_json(silent=True)

    if not data:
        return jsonify({
            "error": "Request body must be valid JSON."
        }), 400

    combined_text = extract_text(data).strip()

    if not combined_text:
        return jsonify({
            "error": "No input provided."
        }), 400

    if len(combined_text) > MAX_INPUT_LENGTH:
        return jsonify({
            "error": f"Input too long. Max {MAX_INPUT_LENGTH} characters."
        }), 413

    try:

        result = detect_philosophy(combined_text)

        return jsonify(result), 200

    except Exception as exc:

        logger.error(
            "req=%s Unhandled error: %s",
            g.req_id,
            exc,
        )

        return jsonify({
            "error": "Something went wrong. Please try again."
        }), 500


@app.route("/api/philosophies", methods=["GET"])
def list_philosophies():

    slim = [
        {
            "id": p["id"],
            "philosophy": p["philosophy"],
            "color": p["color"],
            "icon": p["icon"],
        }
        for p in PHILOSOPHIES
    ]

    return jsonify({
        "philosophies": slim,
        "count": len(slim),
    }), 200


@app.route("/health", methods=["GET"])
def health():

    openrouter_ready = get_openrouter_key() is not None

    return jsonify({
        "status": "ok",
        "openrouter": openrouter_ready,
    }), 200


# ──────────────────────────────────────────────────────────────────────────────
# Error Handlers
# ──────────────────────────────────────────────────────────────────────────────

@app.errorhandler(404)
def not_found(_):
    return jsonify({
        "error": "Endpoint not found."
    }), 404


@app.errorhandler(405)
def method_not_allowed(_):
    return jsonify({
        "error": "Method not allowed."
    }), 405


@app.errorhandler(429)
def rate_limit_exceeded(_):
    return jsonify({
        "error": "Too many requests. Slow down."
    }), 429


# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    app.run(
        debug=False,
        host="0.0.0.0",
        port=5000,
    )
