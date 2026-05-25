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
from groq import Groq

load_dotenv()

# ── Logging ────────────────────────────────────────────────────────────────────

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)
logger = logging.getLogger(__name__)

# ── App setup ──────────────────────────────────────────────────────────────────

app = Flask(__name__)
CORS(app)

storage_uri = os.getenv("REDIS_URL", "memory://")  # swap to Redis in prod
limiter = Limiter(
    get_remote_address,
    app=app,
    default_limits=["200 per day", "50 per hour"],
    storage_uri=storage_uri,
)

MAX_INPUT_LENGTH = 2000

# ── Groq singleton ─────────────────────────────────────────────────────────────

_groq_client: Groq | None = None


def get_groq_client() -> Groq | None:
    global _groq_client
    api_key = os.getenv("GROQ_API_KEY")
    if not api_key:
        return None
    if _groq_client is None:
        _groq_client = Groq(api_key=api_key)
    return _groq_client


# ── 21 Philosophical Isms ──────────────────────────────────────────────────────
# Each entry includes: id, philosophy (display name), color, icon,
# keywords (for keyword fallback), and a reason (call‑to‑action).

PHILOSOPHIES = [
    # ── Meaning & Existence ──────────────────────────────────────────────────
    {
        "id": "stoicism",
        "philosophy": "Stoicism",
        "color": "#D4AF37",
        "icon": "🏛️",
        "keywords": [
            "control", "can't change", "accept", "stress", "anxiety",
            "overwhelm", "calm", "resilience", "what can I do",
            "outside my control", "things happen", "peace",
            "serenity", "focus on what matters", "let go",
        ],
        "reason": (
            "The Stoic hammer: separate what you can control from what you can't. "
            "Invest everything in the first, nothing in the second. "
            "Today, when a worry hits, ask yourself: 'Is this mine to fix?' "
            "If not, release it. If yes, act."
        ),
    },
    {
        "id": "existentialism",
        "philosophy": "Existentialism",
        "color": "#7F8C8D",
        "icon": "🎭",
        "keywords": [
            "meaning", "purpose", "life has no point", "lost", "direction",
            "why am I here", "no meaning", "create your own", "freedom",
            "choice", "no one cares", "nothing matters",
            "existential", "create meaning", "my life is pointless",
        ],
        "reason": (
            "Existence precedes essence – you are not born with a purpose; "
            "you build it through action. The weight of total freedom can be "
            "crippling, but it’s also your power. Make one decision today purely "
            "because you choose it, not because it’s expected."
        ),
    },
    {
        "id": "nihilism",
        "philosophy": "Nihilism",
        "color": "#2C3E50",
        "icon": "🕳️",
        "keywords": [
            "nothing matters", "no point", "empty", "no meaning",
            "why bother", "everything is pointless", "no value",
            "life is meaningless", "existential crisis", "apathy",
            "indifferent", "no reason to live",
        ],
        "reason": (
            "If nothing has inherent meaning, then you are free to create your own. "
            "The world won’t hand you a purpose – that’s liberating, not terrifying. "
            "Ask yourself: what would you do if nothing mattered? "
            "Now go do that, because nothing does."
        ),
    },
    {
        "id": "absurdism",
        "philosophy": "Absurdism",
        "color": "#BF5AF2",
        "icon": "🎪",
        "keywords": [
            "absurd", "ridiculous", "meaningless universe", "laugh at it",
            "why does this happen", "no reason", "embrace chaos",
            "life is a joke", "random", "nothing makes sense",
            "absurdity", "pointless but I keep going",
        ],
        "reason": (
            "Camus knew that Sisyphus must be imagined happy. "
            "The universe is silent; that’s not a tragedy, it’s an invitation. "
            "Today, do one thing that has no practical purpose, purely for the joy of it. "
            "Laugh at the absurdity, then push the rock."
        ),
    },
    {
        "id": "humanism",
        "philosophy": "Humanism",
        "color": "#4A90D9",
        "icon": "🤝",
        "keywords": [
            "human dignity", "reason", "compassion", "empathy", "science",
            "ethics without religion", "human potential", "do good",
            "kindness", "people matter", "human rights", "secular",
            "help others", "community",
        ],
        "reason": (
            "You don’t need a god to be good. Humanism places the weight of ethics "
            "squarely on our own shoulders – and that’s empowering. "
            "Perform an act of kindness today with no expectation of reward. "
            "Reason and compassion are your compass."
        ),
    },
    {
        "id": "fatalism",
        "philosophy": "Fatalism",
        "color": "#8E44AD",
        "icon": "🕸️",
        "keywords": [
            "fate", "destiny", "predetermined", "it is what it is",
            "nothing I can do", "everything happens for a reason",
            "written", "can't escape", "inevitable", "what will be will be",
        ],
        "reason": (
            "If the future is already written, anxiety about it is a thief. "
            "Focus on the present moment – it’s the only point of power you have. "
            "Today, let go of one outcome you’re desperately trying to control. "
            "Trust the process."
        ),
    },
    # ── Self & Society ───────────────────────────────────────────────────────
    {
        "id": "individualism",
        "philosophy": "Individualism",
        "color": "#E91E63",
        "icon": "🧍",
        "keywords": [
            "self-reliance", "be yourself", "independence", "don't follow the crowd",
            "my own path", "freedom", "autonomy", "self-interest",
            "think for yourself", "nonconformity", "unique",
        ],
        "reason": (
            "Your life is your own. Society’s expectations are not a script you must follow. "
            "Make one decision today based purely on your own values, ignoring others’ opinions. "
            "The only approval you need is your own."
        ),
    },
    {
        "id": "collectivism",
        "philosophy": "Collectivism",
        "color": "#2ECC71",
        "icon": "🤲",
        "keywords": [
            "group", "community", "together", "team", "solidarity",
            "shared", "common good", "we not me", "society",
            "cooperation", "help each other", "social responsibility",
        ],
        "reason": (
            "None of us is as strong as all of us. The needs of the many outweigh the needs of the few. "
            "Do something today that benefits your community without seeking personal credit. "
            "Real power comes from the bonds we build."
        ),
    },
    {
        "id": "minimalism",
        "philosophy": "Minimalism",
        "color": "#A5D6A7",
        "icon": "🪴",
        "keywords": [
            "less is more", "declutter", "simplify", "minimal", "too much stuff",
            "overwhelmed by things", "own less", "simple living",
            "need less", "let go of possessions", "tidy up",
        ],
        "reason": (
            "Everything you own owns you a little bit. "
            "Remove one physical item from your space that you haven’t used in a month. "
            "Notice the lightness. Minimalism isn’t about poverty – it’s about freedom from clutter."
        ),
    },
    {
        "id": "hedonism",
        "philosophy": "Hedonism",
        "color": "#FFC107",
        "icon": "🍇",
        "keywords": [
            "pleasure", "enjoyment", "fun", "happy", "good life",
            "feel good", "sensation", "party", "treat yourself",
            "delight", "joy", "pleasure is good",
        ],
        "reason": (
            "Pleasure isn’t a guilty secret – it’s a legitimate goal. "
            "Do something today purely for enjoyment, without any guilt. "
            "Life is meant to be savored, not just endured."
        ),
    },
    {
        "id": "asceticism",
        "philosophy": "Asceticism",
        "color": "#8D6E63",
        "icon": "🧘",
        "keywords": [
            "discipline", "renounce", "abstain", "fasting", "self-denial",
            "detach", "simple life", "no pleasure", "monk mode",
            "control desires", "give up", "sacrifice comfort",
        ],
        "reason": (
            "Strength comes from voluntary discomfort. "
            "Skip one comfort today – your favorite snack, warm shower – "
            "and observe your mind’s reaction. You are not your desires. "
            "Mastery begins where indulgence ends."
        ),
    },
    {
        "id": "pragmatism",
        "philosophy": "Pragmatism",
        "color": "#607D8B",
        "icon": "🔧",
        "keywords": [
            "practical", "what works", "useful", "solution", "fix it",
            "no theory", "just do it", "results", "effective",
            "trial and error", "test it", "realistic",
        ],
        "reason": (
            "Ideas are only as good as their results. "
            "Take one problem today and try the simplest solution. "
            "Judge it solely by the outcome. Pragmatism isn’t cynical – it’s efficient."
        ),
    },
    # ── Mental & Emotional Approaches ────────────────────────────────────────
    {
        "id": "optimism",
        "philosophy": "Optimism",
        "color": "#FFEB3B",
        "icon": "🌞",
        "keywords": [
            "hope", "positive", "good things coming", "bright side",
            "expect the best", "silver lining", "glass half full",
            "believe it will get better", "optimistic",
        ],
        "reason": (
            "Your expectation shapes your reality more than you think. "
            "Reframe one negative event today by finding a genuine silver lining. "
            "Optimism isn’t naivety – it’s a force multiplier."
        ),
    },
    {
        "id": "pessimism",
        "philosophy": "Pessimism",
        "color": "#37474F",
        "icon": "🌧️",
        "keywords": [
            "worst case", "expect the worst", "suffering is life",
            "disappointment", "nothing good happens", "why bother",
            "negative", "pessimist", "it won't work", "all bad",
        ],
        "reason": (
            "A little defensive pessimism can be a superpower – it prepares you for the worst. "
            "Mentally rehearse the worst‑case scenario for one worry today, then plan how you’d handle it. "
            "You’ll feel more in control afterwards."
        ),
    },
    {
        "id": "cynicism",
        "philosophy": "Cynicism",
        "color": "#66BB6A",
        "icon": "🐕",
        "keywords": [
            "question everything", "don't trust", "skeptical", "hypocrisy",
            "fake", "disillusioned", "they're all liars",
            "don't believe", "doubt", "see through it",
        ],
        "reason": (
            "A healthy dose of cynicism protects you from manipulation. "
            "Challenge one social norm today that you find hypocritical. "
            "Question, but don’t become bitter – let your doubt sharpen your mind."
        ),
    },
    {
        "id": "romanticism",
        "philosophy": "Romanticism",
        "color": "#E91E63",
        "icon": "🌹",
        "keywords": [
            "emotion", "passion", "feeling", "heart over head",
            "beauty", "nature", "love", "romantic", "intense",
            "follow your heart", "imagination",
        ],
        "reason": (
            "Logic alone makes life sterile. Express a feeling through art, music, or writing today – "
            "without judging the result. Romanticism reminds us that not everything valuable can be measured."
        ),
    },
    {
        "id": "realism",
        "philosophy": "Realism",
        "color": "#607D8B",
        "icon": "👁️",
        "keywords": [
            "reality", "facts", "honest", "practical", "see it as it is",
            "no sugarcoating", "truth", "objective", "hard truth",
            "face reality", "down to earth",
        ],
        "reason": (
            "Wishful thinking never moved a stone. Describe a situation today using only observable facts, "
            "no interpretations. Realism gives you solid ground to build on."
        ),
    },
    # ── Spiritual / Eastern Approaches ───────────────────────────────────────
    {
        "id": "buddhism",
        "philosophy": "Buddhism",
        "color": "#FFA726",
        "icon": "☸️",
        "keywords": [
            "mindfulness", "meditate", "suffering", "attachment",
            "let go", "impermanence", "calm mind", "enlightenment",
            "peace within", "detachment", "non-attachment",
        ],
        "reason": (
            "Suffering comes from attachment, and the path to peace is mindfulness. "
            "Practice five minutes of meditation today – just observe your breath. "
            "Everything changes; clinging only brings pain."
        ),
    },
    {
        "id": "taoism",
        "philosophy": "Taoism",
        "color": "#66BB6A",
        "icon": "☯️",
        "keywords": [
            "flow", "wu wei", "effortless", "go with the flow",
            "nature", "balance", "harmony", "don't force",
            "let it happen", "Tao", "the way",
        ],
        "reason": (
            "Water is the softest thing, yet it wears down mountains. "
            "Today, do one thing without forcing – allow it to unfold naturally. "
            "The Tao teaches that true power is effortless."
        ),
    },
    {
        "id": "confucianism",
        "philosophy": "Confucianism",
        "color": "#D32F2F",
        "icon": "📜",
        "keywords": [
            "respect", "duty", "order", "tradition", "family",
            "elders", "virtue", "propriety", "moral",
            "righteous", "social harmony", "filial piety",
        ],
        "reason": (
            "A well‑ordered life starts with respect and self‑cultivation. "
            "Show extra respect to an elder or mentor today – listen deeply. "
            "Your character is the foundation of everything you build."
        ),
    },
]

DEFAULT_RESPONSE = {
    "philosophy": "Forge Yourself",
    "color": "#FF9500",
    "icon": "⚒️",
    "reason": (
        "No clear enemy identified — which means the real obstacle is you. "
        "Pick the one thing you've been avoiding and attack it today. "
        "Clarity comes from doing, not thinking."
    ),
    "matched_keywords": [],
    "score": 0,
    "source": "default",
    "confidence": "low",
}

# ── Helpers ────────────────────────────────────────────────────────────────────

def sanitize(text: str) -> str:
    """Strip control characters, keep printable Unicode."""
    return "".join(c for c in text if not unicodedata.category(c).startswith("C") or c in "\n\t ")


def keyword_detect(text: str) -> dict:
    """
    Context‑aware keyword matching.
    - Each keyword has a base weight proportional to its length.
    - Requires at least 2 matches OR a phrase of 4+ words to avoid one‑hit wonders.
    - Falls back to default if nothing is strong enough.
    """
    text_lower = sanitize(text).lower()
    best_score = 0
    best_match = None
    best_keywords = []

    for entry in PHILOSOPHIES:
        matched = []
        for kw in entry["keywords"]:
            # Use word boundary regex
            if re.search(rf"\b{re.escape(kw)}\b", text_lower):
                # Weight = number of words in the keyword (so phrases count more)
                weight = len(kw.split())
                matched.append((kw, weight))

        # Skip philosophies with too few / too weak matches
        total_weight = sum(w for _, w in matched)
        if total_weight < 2 and not any(w >= 3 for _, w in matched):
            continue   # needs at least 2 weight points or a 3‑word phrase

        if total_weight > best_score:
            best_score = total_weight
            best_match = entry
            best_keywords = [k for k, _ in matched]

    if not best_match:
        return DEFAULT_RESPONSE

    confidence = "high" if best_score >= 6 else "medium" if best_score >= 3 else "low"
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

def ask_groq(text: str) -> dict:
    """
    Call Groq LLM. Raises on any failure so detect_philosophy()
    can fall back to keywords cleanly.
    """
    client = get_groq_client()
    if client is None:
        raise ValueError("GROQ_API_KEY not configured")

    # Updated to use the new 21‑ism names
    philosophy_names = [p["philosophy"] for p in PHILOSOPHIES]
    philosophy_list = "\n".join(f"- {n}" for n in philosophy_names)

    response = client.chat.completions.create(
        model="llama3-8b-8192",
        temperature=0.6,
        max_tokens=350,
        messages=[
            {
                "role": "system",
                "content": (
                    "You are a philosophical diagnostician. "
                    "Analyze the user's emotional state and situation, then select "
                    "the single best-fit philosophy from this list ONLY:\n"
                    f"{philosophy_list}\n\n"
                    "Return ONLY a raw JSON object with exactly these keys:\n"
                    "  'philosophy': the exact philosophy name from the list above\n"
                    "  'reason': a direct, no-nonsense call to action under 80 words — "
                    "no hand-holding, no coddling, just truth and forward motion.\n"
                    "No markdown, no code fences, no preamble. Just the JSON object."
                ),
            },
            {"role": "user", "content": sanitize(text)},
        ],
    )

    raw = response.choices[0].message.content.strip()

    # Strip markdown fences defensively
    if raw.startswith("```"):
        parts = raw.split("```")
        raw = parts[1] if len(parts) > 1 else raw
        if raw.startswith("json"):
            raw = raw[4:]
        raw = raw.strip()

    parsed = json.loads(raw)

    # Validate required keys
    if "philosophy" not in parsed or "reason" not in parsed:
        raise ValueError(f"Groq returned unexpected schema: {list(parsed.keys())}")

    # Enrich with color/icon from our PHILOSOPHIES list
    matched_meta = next(
        (p for p in PHILOSOPHIES if p["philosophy"] == parsed["philosophy"]),
        None,
    )

    return {
        "philosophy": parsed["philosophy"],
        "color": matched_meta["color"] if matched_meta else "#FF9500",
        "icon": matched_meta["icon"] if matched_meta else "⚡",
        "reason": parsed["reason"],
        "matched_keywords": [],
        "score": 0,
        "source": "groq",
        "confidence": "high",
    }


def detect_philosophy(text: str) -> dict:
    """Try Groq first; silently fall back to keyword detection on any failure."""
    req_id = getattr(g, "req_id", "?")
    try:
        result = ask_groq(text)
        logger.info("req=%s source=groq philosophy=%s", req_id, result["philosophy"])
        return result
    except Exception as exc:
        logger.warning("req=%s Groq failed (%s), falling back to keywords", req_id, exc)
        result = keyword_detect(text)
        logger.info("req=%s source=keywords philosophy=%s score=%s",
                    req_id, result["philosophy"], result["score"])
        return result


def extract_text(data: dict) -> str:
    """Accept {text: '...'} or {answers: ['...', '...']} payloads."""
    if "text" in data:
        return str(data["text"])
    answers = data.get("answers", [])
    if isinstance(answers, list):
        return " ".join(str(a) for a in answers if a)
    return str(answers)


# ── Request hooks ──────────────────────────────────────────────────────────────

@app.before_request
def assign_request_id():
    g.req_id = str(uuid.uuid4())[:8]


# ── Routes ─────────────────────────────────────────────────────────────────────

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
    except Exception as exc:
        logger.error("req=%s Unhandled error: %s", g.req_id, exc)
        return jsonify({"error": "Something went wrong. Please try again."}), 500


@app.route("/api/philosophies", methods=["GET"])
def list_philosophies():
    """Return the full philosophy catalogue for onboarding/display."""
    slim = [
        {"id": p["id"], "philosophy": p["philosophy"],
         "color": p["color"], "icon": p["icon"]}
        for p in PHILOSOPHIES
    ]
    return jsonify({"philosophies": slim, "count": len(slim)}), 200


@app.route("/health", methods=["GET"])
def health():
    groq_ready = get_groq_client() is not None
    return jsonify({"status": "ok", "groq": groq_ready}), 200


# ── Error handlers ─────────────────────────────────────────────────────────────

@app.errorhandler(404)
def not_found(_):
    return jsonify({"error": "Endpoint not found."}), 404


@app.errorhandler(405)
def method_not_allowed(_):
    return jsonify({"error": "Method not allowed."}), 405


@app.errorhandler(429)
def rate_limit_exceeded(_):
    return jsonify({"error": "Too many requests. Slow down and try again."}), 429


# ── Entry point ────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5000)
