from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

# ── App setup ────────────────────────────────────────────────────────────────

app = Flask(__name__)
CORS(app)

limiter = Limiter(
    get_remote_address,
    app=app,
    default_limits=["200 per day", "50 per hour"],
    storage_uri="redis://localhost:6379",
)

# ── Constants ─────────────────────────────────────────────────────────────────

MAX_INPUT_LENGTH = 2000

# ── Philosophy definitions ────────────────────────────────────────────────────

PHILOSOPHIES = [
    {
        "id": "stoicism",
        "philosophy": "Practical Stoicism",
        "keywords": [
            "paralyzed", "stuck", "can't start", "cant start",
            "overwhelmed", "anxious", "anxiety", "frozen", "panicking",
            "panic", "nervous", "stressed", "stress", "dread",
        ],
        "reason": (
            "You feel stuck or overwhelmed. Stoicism, practiced gently, "
            "asks one question: 'What can you do right now, in this moment?' "
            "Not to suppress feelings — but to find one small action you control. "
            "Start there. Just one thing."
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
            "Comparing yourself to others is painful — but it's also deeply human. "
            "Instead of forcing yourself to 'overcome' through willpower, try "
            "treating yourself the way you'd treat a close friend who came to you "
            "with this exact pain: with kindness, not judgment."
        ),
    },
    {
        "id": "existential_humanism",
        "philosophy": "Existential Humanism",
        "keywords": [
            "nothing matters", "meaningless", "why try", "pointless",
            "no purpose", "empty", "emptiness", "what's the point",
            "whats the point", "no reason", "nihilism", "nihilistic",
        ],
        "reason": (
            "When life feels meaningless, the existentialists actually agree with you — "
            "no cosmic meaning is handed to us. But that's the liberating part: "
            "you get to *create* your own meaning through relationships, creativity, "
            "and the small daily choices that define who you are."
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
            "Grief isn't a problem to be solved — it's love with nowhere to go. "
            "ACT doesn't ask you to 'get over it.' It asks you to feel the pain "
            "fully, without letting it become the only thing you are. "
            "You can carry loss and still move toward what matters."
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
            "Anger often points at something real — an injustice, a violation of "
            "your values. Aristotle didn't say to suppress anger; he said to feel it "
            "at the *right* thing, in the *right* amount, at the *right* time. "
            "The question isn't 'why am I angry?' — it's 'what does this anger tell "
            "me about what I value?'"
        ),
    },
    {
        "id": "taoism",
        "philosophy": "Taoist Wu Wei",
        "keywords": [
            "burnout", "burned out", "exhausted", "exhaustion", "drained",
            "tired", "no energy", "running on empty", "overworked",
            "too much", "can't keep up", "cant keep up", "falling behind",
            "doing too much",
        ],
        "reason": (
            "Wu Wei — 'effortless action' — isn't laziness. It's the Taoist insight "
            "that constant forcing eventually breaks things, including people. "
            "Water doesn't fight the rock; it flows around it and still carves canyons. "
            "Rest isn't giving up. It's part of the work."
        ),
    },
    {
        "id": "growth_mindset",
        "philosophy": "Growth Mindset (Carol Dweck)",
        "keywords": [
            "fear of failure", "afraid to fail", "scared to try", "what if i fail",
            "what if i mess up", "can't do it", "cant do it", "not smart enough",
            "not talented", "too hard", "i'll never", "ill never", "give up",
            "giving up", "impossible",
        ],
        "reason": (
            "The fear of failure isn't a sign you're weak — it's a sign you care. "
            "Dweck's research shows that talent is far less important than believing "
            "your abilities can grow. Every expert was once a beginner who kept going. "
            "The attempt itself is the point, not the outcome."
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
            "Buddhism teaches that the feeling of being a separate, isolated self "
            "is itself the illusion causing most suffering. You are made of every "
            "person who ever taught you something, fed you, loved you, or crossed "
            "your path. Loneliness is real — but so is your deep connection to "
            "everything around you."
        ),
    },
    {
        "id": "stoic_mortality",
        "philosophy": "Memento Mori (Stoic Reflection)",
        "keywords": [
            "wasting time", "wasted my life", "running out of time", "getting old",
            "mortality", "death", "dying", "time is running out", "too late",
            "regret", "regrets", "should have", "wish i had", "what have i done",
        ],
        "reason": (
            "Memento Mori — 'remember you will die' — sounds dark, but the Stoics "
            "used it as a clarifying tool, not a morbid one. When you truly feel "
            "the limits of your time, trivial things stop mattering and the things "
            "that *do* matter become obvious. It's the ultimate focus tool."
        ),
    },
    {
        "id": "pragmatism",
        "philosophy": "Pragmatism (William James)",
        "keywords": [
            "confused", "don't know what to do", "dont know what to do",
            "no direction", "lost", "unclear", "which path", "what should i do",
            "decision", "can't decide", "cant decide", "unsure", "uncertain",
        ],
        "reason": (
            "Pragmatism says: stop waiting for the perfect answer and test something. "
            "An idea is only as good as what it does in the real world. Pick the "
            "smallest possible action that moves you in a direction, try it, and "
            "let the result tell you what to do next. Clarity comes from doing, "
            "not from thinking alone."
        ),
    },
]

DEFAULT_RESPONSE = {
    "philosophy": "Balanced Living",
    "reason": (
        "You're asking the right questions. Real self-improvement isn't about "
        "being extreme — it's about being slightly better than yesterday, while "
        "staying kind to yourself and others."
    ),
    "matched_keywords": [],
    "score": 0,
}

# ── Core logic ────────────────────────────────────────────────────────────────

def detect_philosophy(text: str) -> dict:
    text_lower = text.lower()
    best_score = 0
    best_match = None
    best_keywords = []

    for entry in PHILOSOPHIES:
        matched = [kw for kw in entry["keywords"] if kw in text_lower]
        score = len(matched)
        if score > best_score:
            best_score = score
            best_match = entry
            best_keywords = matched

    if best_match is None:
        return DEFAULT_RESPONSE

    return {
        "philosophy": best_match["philosophy"],
        "reason": best_match["reason"],
        "matched_keywords": best_keywords,
        "score": best_score,
    }


def extract_text(data: dict) -> str:
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
        app.logger.error("Unexpected error in /api/diagnose: %s", e)
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
