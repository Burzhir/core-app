import os
import json
from dotenv import load_dotenv
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from groq import Groq

load_dotenv()

# ── App setup ─────────────────────────────────────────────────────────────────

app = Flask(__name__)
CORS(app)

limiter = Limiter(
    get_remote_address,
    app=app,
    default_limits=["200 per day", "50 per hour"],
    storage_uri="memory://",
)

MAX_INPUT_LENGTH = 2000

# ── Keyword fallback ──────────────────────────────────────────────────────────

PHILOSOPHIES = [
    {
        "id": "stoicism",
        "philosophy": "Practical Stoicism",
        "keywords": [
            "paralyzed", "stuck", "cant start", "overwhelmed", "anxious",
            "anxiety", "frozen", "panicking", "panic", "nervous",
            "stressed", "stress", "dread",
        ],
        "reason": (
            "You feel stuck or overwhelmed. Stoicism asks one question: "
            "'What can you do right now?' Not to suppress feelings — but to "
            "find one small action you control. Start there. Just one thing."
        ),
    },
    {
        "id": "self_compassion",
        "philosophy": "Self-Compassion (Kristin Neff)",
        "keywords": [
            "compare", "comparison", "envy", "not good enough", "jealous",
            "behind", "failure", "failing", "loser", "worthless", "inferior",
            "everyone else", "they have", "she has", "he has",
        ],
        "reason": (
            "Comparing yourself to others is painful but human. Try treating "
            "yourself the way you'd treat a close friend in this exact pain: "
            "with kindness, not judgment."
        ),
    },
    {
        "id": "existential_humanism",
        "philosophy": "Existential Humanism",
        "keywords": [
            "nothing matters", "meaningless", "why try", "pointless",
            "no purpose", "empty", "emptiness", "whats the point",
            "no reason", "nihilism", "nihilistic",
        ],
        "reason": (
            "No cosmic meaning exists — but that's liberating. You get to "
            "create your own through relationships, creativity, and the small "
            "daily choices that define who you are."
        ),
    },
    {
        "id": "act_grief",
        "philosophy": "Acceptance & Commitment Therapy (ACT)",
        "keywords": [
            "grief", "grieving", "loss", "lost someone", "death", "died",
            "passed away", "missing", "miss them", "gone", "heartbreak",
            "heartbroken", "breakup", "broke up", "divorce", "separated",
        ],
        "reason": (
            "Grief isn't a problem to solve — it's love with nowhere to go. "
            "ACT asks you to feel it fully without letting it become the only "
            "thing you are. You can carry loss and still move toward what matters."
        ),
    },
    {
        "id": "virtue_ethics",
        "philosophy": "Virtue Ethics (Aristotle)",
        "keywords": [
            "angry", "anger", "rage", "furious", "injustice", "unfair",
            "not fair", "cheated", "wronged", "betrayed", "betrayal",
            "lied to", "disrespected", "treated badly", "resentment", "resent",
        ],
        "reason": (
            "Anger points at something real — a violation of your values. "
            "Aristotle said feel it at the right thing, in the right amount. "
            "What does this anger tell you about what you value?"
        ),
    },
    {
        "id": "taoism",
        "philosophy": "Taoist Wu Wei",
        "keywords": [
            "burnout", "burned out", "exhausted", "exhaustion", "drained",
            "tired", "no energy", "running on empty", "overworked",
            "too much", "cant keep up", "falling behind", "doing too much",
        ],
        "reason": (
            "Constant forcing eventually breaks things, including people. "
            "Water carves canyons without fighting the rock. "
            "Rest isn't giving up — it's part of the work."
        ),
    },
    {
        "id": "growth_mindset",
        "philosophy": "Growth Mindset (Carol Dweck)",
        "keywords": [
            "afraid to fail", "scared to try", "what if i fail",
            "what if i mess up", "cant do it", "not smart enough",
            "not talented", "too hard", "ill never", "give up",
            "giving up", "impossible",
        ],
        "reason": (
            "Fear of failure means you care. Dweck's research shows talent "
            "matters far less than believing you can grow. Every expert was "
            "a beginner who kept going. The attempt is the point."
        ),
    },
    {
        "id": "buddhism",
        "philosophy": "Buddhist Interconnectedness",
        "keywords": [
            "lonely", "loneliness", "alone", "isolated", "no one understands",
            "nobody cares", "no friends", "disconnected", "invisible",
            "no one sees me", "left out", "excluded", "rejected", "rejection",
        ],
        "reason": (
            "The feeling of total isolation is itself the illusion causing "
            "most suffering. You are made of everyone who ever taught, fed, "
            "or loved you. Loneliness is real — but so is your connection to everything."
        ),
    },
    {
        "id": "stoic_mortality",
        "philosophy": "Memento Mori (Stoic Reflection)",
        "keywords": [
            "wasting time", "wasted my life", "running out of time",
            "getting old", "mortality", "dying", "time is running out",
            "too late", "regret", "regrets", "should have", "wish i had",
        ],
        "reason": (
            "Remembering you will die clarifies everything. Trivial things "
            "stop mattering and what truly matters becomes obvious. "
            "It's the ultimate focus tool, not a morbid one."
        ),
    },
    {
        "id": "pragmatism",
        "philosophy": "Pragmatism (William James)",
        "keywords": [
            "confused", "dont know what to do", "no direction", "lost",
            "unclear", "which path", "what should i do", "cant decide",
            "unsure", "uncertain", "decision",
        ],
        "reason": (
            "Stop waiting for the perfect answer — test something. "
            "An idea is only as good as what it does in the real world. "
            "Clarity comes from doing, not from thinking alone."
        ),
    },
]

DEFAULT_RESPONSE = {
    "philosophy": "Balanced Living",
    "reason": (
        "You're asking the right questions. Real growth isn't extreme — "
        "it's being slightly better than yesterday while staying kind to yourself."
    ),
    "matched_keywords": [],
    "score": 0,
    "source": "default",
}

# ── Core logic ────────────────────────────────────────────────────────────────

def keyword_detect(text: str) -> dict:
    """Score all philosophies and return best match. Always works, no API needed."""
    text_lower = text.lower()
    best_score, best_match, best_keywords = 0, None, []

    for entry in PHILOSOPHIES:
        matched = [kw for kw in entry["keywords"] if kw in text_lower]
        if len(matched) > best_score:
            best_score = len(matched)
            best_match = entry
            best_keywords = matched

    if not best_match:
        return DEFAULT_RESPONSE

    return {
        "philosophy": best_match["philosophy"],
        "reason": best_match["reason"],
        "matched_keywords": best_keywords,
        "score": best_score,
        "source": "keywords",
    }


def ask_groq(text: str) -> dict:
    """
    Client created here, not at module level.
    If the key is missing or Groq fails, raises an exception
    and detect_philosophy() falls back to keywords automatically.
    """
    api_key = os.getenv("GROQ_API_KEY")
    if not api_key:
        raise ValueError("GROQ_API_KEY not set — falling back to keywords")

    client = Groq(api_key=api_key)

    response = client.chat.completions.create(
        model="llama3-8b-8192",
        temperature=0.7,
        max_tokens=300,
        messages=[
            {
                "role": "system",
                "content": (
                    "You are a philosophical diagnostician. Analyze the user's "
                    "emotional state and return ONLY a raw JSON object with exactly "
                    "two keys: 'philosophy' (the name of the best-fit philosophical "
                    "framework) and 'reason' (a compassionate explanation under 100 words). "
                    "No markdown, no code fences, no preamble. Just the JSON object."
                ),
            },
            {"role": "user", "content": text},
        ],
    )

    raw = response.choices[0].message.content.strip()

    # Strip markdown fences if the model added them anyway
    if raw.startswith("```"):
        raw = raw.split("```")[1]
        if raw.startswith("json"):
            raw = raw[4:]
        raw = raw.strip()

    parsed = json.loads(raw)
    parsed["source"] = "groq"
    parsed["matched_keywords"] = []
    parsed["score"] = 0
    return parsed


def detect_philosophy(text: str) -> dict:
    """Try Groq first. If anything fails, fall back to keywords silently."""
    try:
        return ask_groq(text)
    except Exception as e:
        app.logger.warning("Groq failed, using keyword fallback: %s", e)
        return keyword_detect(text)


def extract_text(data: dict) -> str:
    """Accept both {text: '...'} and {answers: ['...', '...']} shapes."""
    if "text" in data:
        return str(data["text"])
    answers = data.get("answers", [])
    if isinstance(answers, list):
        return " ".join(str(a) for a in answers if a)
    return str(answers)


# ── Routes ────────────────────────────────────────────────────────────────────

@app.route("/api/diagnose", methods=["POST"])
@limiter.limit("30 per minute")
def diagnose():
    data = request.get_json(silent=True)
    if not data:
        return jsonify({"error": "Request body must be valid JSON."}), 400

    combined_text = extract_text(data).strip()
    if not combined_text:
        return jsonify({"error": "No input provided. Send 'answers' or 'text'."}), 400
    if len(combined_text) > MAX_INPUT_LENGTH:
        return jsonify({"error": f"Input too long. Max {MAX_INPUT_LENGTH} characters."}), 413

    try:
        result = detect_philosophy(combined_text)
        return jsonify(result), 200
    except Exception as e:
        app.logger.error("Unhandled error in /api/diagnose: %s", e)
        return jsonify({"error": "Something went wrong. Please try again."}), 500


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200


@app.errorhandler(404)
def not_found(_):
    return jsonify({"error": "Endpoint not found."}), 404


@app.errorhandler(405)
def method_not_allowed(_):
    return jsonify({"error": "Method not allowed."}), 405


@app.errorhandler(429)
def rate_limit_exceeded(_):
    return jsonify({"error": "Too many requests. Slow down and try again."}), 429


# ── Entry point ───────────────────────────────────────────────────────────────

if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5000)
