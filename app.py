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


# ── 15 Hardcore / Proactive Philosophies ──────────────────────────────────────

PHILOSOPHIES = [
    {
        "id": "spartan_discipline",
        "philosophy": "Spartan Discipline",
        "color": "#FF3B30",
        "icon": "⚔️",
        "keywords": [
            "lazy", "weak", "soft", "comfort zone", "comfortable", "too easy",
            "quit", "quitting", "no discipline", "unmotivated", "no motivation",
            "can't push", "need a push", "procrastinating", "couch",
        ],
        "reason": (
            "Spartans didn't wait to feel ready — they trained until readiness "
            "was irrelevant. Your comfort zone isn't safety, it's slow death. "
            "Pick one hard thing right now and do it before you negotiate with yourself."
        ),
    },
    {
        "id": "extreme_ownership",
        "philosophy": "Extreme Ownership",
        "color": "#FF9500",
        "icon": "🔱",
        "keywords": [
            "blame", "their fault", "not my fault", "victim", "excuse",
            "unfair", "someone else", "they did", "she did", "he did",
            "circumstances", "bad luck", "dealt a bad hand", "system",
        ],
        "reason": (
            "Everything that happens in your life is your responsibility — "
            "not because it's all your fault, but because you are the only "
            "variable you control. Own it completely. Leaders who blame lose. "
            "Leaders who own, win."
        ),
    },
    {
        "id": "will_to_power",
        "philosophy": "Nietzsche's Self-Overcoming",
        "color": "#AF52DE",
        "icon": "⚡",
        "keywords": [
            "mediocre", "average", "ordinary", "plateau", "same as everyone",
            "not special", "nothing special", "stuck at the same level",
            "peaked", "not growing", "stagnant", "going nowhere",
        ],
        "reason": (
            "Nietzsche's demand was radical: become who you are — your "
            "highest possible self — through relentless self-overcoming. "
            "Average is a choice. The herd is comfortable. You aren't here "
            "to be comfortable. Destroy the version of you that accepts less."
        ),
    },
    {
        "id": "bushido",
        "philosophy": "Bushido: The Way of the Warrior",
        "color": "#FF2D55",
        "icon": "🗡️",
        "keywords": [
            "coward", "cowardly", "backing down", "running away", "avoided",
            "dodged", "chickened", "no honor", "dishonest", "lied",
            "no integrity", "compromised", "sold out", "spineless",
        ],
        "reason": (
            "Bushido teaches that a warrior's death begins the moment they "
            "compromise their code. Honor isn't reputation — it's what you do "
            "when no one is watching and when everything is on the line. "
            "Stand in the fire. That's what you're built for."
        ),
    },
    {
        "id": "forty_percent_rule",
        "philosophy": "The 40% Rule",
        "color": "#0A84FF",
        "icon": "💥",
        "keywords": [
            "can't do it", "at my limit", "hit a wall", "can't go on",
            "exhausted", "nothing left", "impossible", "too hard",
            "give up", "giving up", "done", "finished", "can't anymore",
            "my max", "body is done",
        ],
        "reason": (
            "When your mind says you're done, you're at 40% of your actual "
            "capacity. That voice is a liar built from evolution, not truth. "
            "The Navy SEALs proved it, Goggins proved it. The wall is not the "
            "end — it's where the real work starts. Go through it."
        ),
    },
    {
        "id": "warrior_stoicism",
        "philosophy": "Warrior Stoicism (Marcus Aurelius)",
        "color": "#636366",
        "icon": "🏛️",
        "keywords": [
            "complaining", "complain", "whining", "nothing i can do",
            "out of my control", "powerless", "helpless", "no choice",
            "trapped", "stuck with it", "can't change it", "no way out",
        ],
        "reason": (
            "Marcus Aurelius commanded the largest empire on earth and "
            "still woke before dawn to remind himself: focus only on what "
            "you can act on. Complaining is a vote for your own defeat. "
            "Find the one degree you control and execute on it — now."
        ),
    },
    {
        "id": "sun_tzu",
        "philosophy": "Sun Tzu's Strategic Dominance",
        "color": "#30D158",
        "icon": "♟️",
        "keywords": [
            "losing", "outplayed", "outsmarted", "competition", "rival",
            "enemy", "losing the game", "being beaten", "can't win",
            "outmaneuvered", "losing ground", "falling behind them",
            "they're winning", "they're ahead",
        ],
        "reason": (
            "Every battle is won before it's fought. Sun Tzu didn't prize "
            "brute force — he prized positioning, information, and patience. "
            "You don't lose because they're stronger. You lose because you "
            "reacted instead of planned. Study the terrain. Move with purpose."
        ),
    },
    {
        "id": "musashi_mastery",
        "philosophy": "Musashi's Way of the Sword",
        "color": "#FF6B35",
        "icon": "⛩️",
        "keywords": [
            "distracted", "scattered", "unfocused", "doing too many things",
            "jack of all trades", "no focus", "jumping between", "shiny object",
            "can't concentrate", "attention", "switching", "multiple paths",
        ],
        "reason": (
            "Miyamoto Musashi won 61 duels undefeated through one principle: "
            "single-pointed mastery. He didn't diversify. He cut everything "
            "that wasn't the sword. Pick your one path. Then walk it with "
            "such obsession that distraction becomes physically impossible."
        ),
    },
    {
        "id": "seneca_urgency",
        "philosophy": "Seneca's Urgency Doctrine",
        "color": "#FFD60A",
        "icon": "⏳",
        "keywords": [
            "later", "someday", "eventually", "not yet", "when i'm ready",
            "tomorrow", "next week", "next year", "not now", "delay",
            "waiting", "not the right time", "one day", "procrastinate",
        ],
        "reason": (
            "Seneca watched men squander their entire lives waiting for "
            "the perfect moment. 'Omnia aliena sunt, tempus tantum nostrum.' "
            "Everything is borrowed — only time is truly yours, and it's "
            "already bleeding out. Not someday. Today. This hour. Right now."
        ),
    },
    {
        "id": "roosevelts_arena",
        "philosophy": "Roosevelt's Arena",
        "color": "#BF5AF2",
        "icon": "🏟️",
        "keywords": [
            "judged", "what will people think", "afraid to try", "embarrassed",
            "look stupid", "fail publicly", "scared to start", "what if i fail",
            "people are watching", "fear of judgment", "playing it safe",
            "not putting myself out there", "too risky", "exposed",
        ],
        "reason": (
            "It is not the critic who counts. The credit belongs to the man "
            "in the arena — face marred by dust and sweat and blood. "
            "The people watching from the stands have no power over you. "
            "The only shame is never entering the arena at all."
        ),
    },
    {
        "id": "epictetus_fortress",
        "philosophy": "Epictetus' Inner Citadel",
        "color": "#5E5CE6",
        "icon": "🔒",
        "keywords": [
            "what people think", "their opinion", "validation", "approval",
            "rejected", "rejection", "criticized", "people don't like me",
            "need their approval", "caring too much", "reputation",
            "want them to accept", "they don't respect me",
        ],
        "reason": (
            "Epictetus was a slave who became freer than his masters — "
            "because he understood one absolute truth: no one can touch "
            "your inner world without your permission. Their opinion of you "
            "is their business, not yours. Lock the gate. Govern yourself."
        ),
    },
    {
        "id": "alexander_conquest",
        "philosophy": "Alexander's Conquest Mindset",
        "color": "#0A84FF",
        "icon": "👑",
        "keywords": [
            "thinking too small", "small goals", "limited", "realistic",
            "be practical", "can't aim that high", "too ambitious",
            "dream too big", "not possible for me", "out of my league",
            "who am i to", "people like me don't", "that's for others",
        ],
        "reason": (
            "Alexander wept because he had no more worlds to conquer — "
            "at 32. Most people never conquer one. Your 'realistic' goal "
            "is almost certainly too small. Expand the frame. The audacity "
            "of the target is what calls forth the greatness to match it."
        ),
    },
    {
        "id": "mamba_mentality",
        "philosophy": "Mamba Mentality: Obsessive Excellence",
        "color": "#FFD60A",
        "icon": "🐍",
        "keywords": [
            "good enough", "that'll do", "mediocre work", "barely passing",
            "minimum effort", "cutting corners", "half effort", "half-assing",
            "not my best", "could've done more", "settled", "low standard",
            "just okay", "acceptable",
        ],
        "reason": (
            "The Mamba didn't train to be good. He trained at 4am alone "
            "because he was already better than everyone and still wanted more. "
            "Good enough is an insult to your potential. What would your "
            "absolute best look like? Now do that. Every single time."
        ),
    },
    {
        "id": "naval_long_game",
        "philosophy": "Naval's Long-Game Philosophy",
        "color": "#64D2FF",
        "icon": "🚀",
        "keywords": [
            "broke", "no money", "poor", "financial", "wealth", "rich",
            "money problems", "can't get ahead", "short term", "quick money",
            "get rich quick", "desperate for cash", "debt", "no leverage",
            "trading time for money",
        ],
        "reason": (
            "Wealth is built through specific knowledge, leverage, and "
            "compounding — not by selling hours. You want equity, not salary. "
            "Naval's law: play long-term games with long-term people. "
            "Every shortcut is a loan from your future self at ruinous interest."
        ),
    },
    {
        "id": "diogenes_freedom",
        "philosophy": "Diogenes' Radical Freedom",
        "color": "#34C759",
        "icon": "🔥",
        "keywords": [
            "own too much", "attached", "possessions", "stuff", "status",
            "status symbol", "keeping up", "social pressure", "expectations",
            "what society expects", "trapped by", "golden handcuffs",
            "can't leave", "stuck because of", "lifestyle inflation",
        ],
        "reason": (
            "Diogenes owned a bowl — then smashed it when he saw a child "
            "drink from cupped hands. Alexander the Great offered him anything "
            "he wanted; he asked him to move, he was blocking the sun. "
            "The man with nothing to lose answers to no one. What are you "
            "actually protecting? Is it worth the cage?"
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
    Word-boundary regex scoring across all philosophies.
    Always returns a result — zero API dependency.
    """
    text_lower = sanitize(text).lower()
    best_score, best_match, best_keywords = 0, None, []

    for entry in PHILOSOPHIES:
        matched = [
            kw for kw in entry["keywords"]
            if re.search(rf"\b{re.escape(kw)}\b", text_lower)
        ]
        if len(matched) > best_score:
            best_score = len(matched)
            best_match = entry
            best_keywords = matched

    if not best_match:
        return DEFAULT_RESPONSE

    confidence = "high" if best_score >= 3 else "medium" if best_score == 2 else "low"
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
                    "You are a hardcore philosophical diagnostician. "
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
