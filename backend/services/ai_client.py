import os, time, json, re, requests, logging
from flask import g

logger = logging.getLogger(__name__)

# Default full list of free models
DEFAULT_FREE_MODELS = [
    "qwen/qwen3-next-80b-a3b-instruct:free",
    "meta-llama/llama-3.3-70b-instruct:free",
    "meta-llama/llama-3.2-3b-instruct:free",
    "nousresearch/hermes-3-llama-3.1-405b:free",
    "google/gemma-4-31b-it:free",
    "google/gemma-4-26b-a4b-it:free",
    "nvidia/nemotron-3-super-120b-a12b:free",
    "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
    "nvidia/nemotron-3-nano-30b-a3b:free",
    "nvidia/nemotron-nano-12b-v2-vl:free",
    "nvidia/nemotron-nano-9b-v2:free",
    "moonshotai/kimi-k2.6:free",
    "poolside/laguna-xs.2:free",
    "poolside/laguna-m.1:free",
    "liquid/lfm-2.5-1.2b-thinking:free",
    "liquid/lfm-2.5-1.2b-instruct:free",
    "cognitivecomputations/dolphin-mistral-24b-venice-edition:free",
    "openai/gpt-oss-120b:free",
    "openai/gpt-oss-20b:free",
    "z-ai/glm-4.5-air:free",
    "qwen/qwen3-coder:free",
    "openrouter/free",
]
DEFAULT_FREE_MODELS = list(dict.fromkeys(DEFAULT_FREE_MODELS))

# Priority models (tried first, no sleep between them)
PRIORITY_MODELS = os.getenv(
    "PRIORITY_MODELS",
    "PRIORITY_MODELS=google/gemma-4-26b-a4b-it:free,qwen/qwen3-next-80b-a3b-instruct:free,meta-llama/llama-3.3-70b-instruct:free"
).split(",")
PRIORITY_MODELS = [m.strip() for m in PRIORITY_MODELS if m.strip()]

# Maximum total time (seconds) to spend trying models before giving up
MAX_TRY_TIME = float(os.getenv("MAX_AI_TRY_TIME", "7.0"))


def _try_openrouter(messages: list, model: str, temperature: float, max_tokens: int) -> dict:
    """Attempt a single OpenRouter call with a specific model."""
    api_key = os.getenv("OPENROUTER_API_KEY")
    if not api_key:
        raise ValueError("OPENROUTER_API_KEY is not set")

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": os.getenv("APP_URL", "http://localhost:3000"),
        "X-Title": "CORE App",
    }

    payload = {
        "model": model,
        "messages": messages,
        "temperature": temperature,
        "max_tokens": max_tokens,
        "provider": {"allow_fallbacks": True},
    }

    start = time.time()
    resp = requests.post(
        "https://openrouter.ai/api/v1/chat/completions",
        headers=headers,
        json=payload,
        timeout=10,  # per-model timeout (shorter than before)
    )
    elapsed_ms = int((time.time() - start) * 1000)
    req_id = getattr(g, "req_id", "?")
    logger.info("req=%s model=%s ms=%d status=%d", req_id, model, elapsed_ms, resp.status_code)

    if resp.status_code == 429:
        # Rate limited – we'll skip to next model quickly
        raise Exception("rate limited")
    if resp.status_code != 200:
        raise Exception(f"status {resp.status_code}")

    data = resp.json()
    raw = data["choices"][0]["message"]["content"].strip()
    if raw.startswith("```"):
        raw = raw.replace("```json", "").replace("```", "").strip()
    return {"content": raw}


def call_openrouter(messages: list, temperature: float = 0.6, max_tokens: int = 300) -> dict:
    """
    Try priority models first, then the rest of the free list.
    Stop if total elapsed time exceeds MAX_TRY_TIME.
    Raises an exception if no model responds in time.
    """
    # Build combined list: priority first, then remaining free models (without duplicates)
    tried = set()
    combined = []
    for m in PRIORITY_MODELS:
        if m not in tried:
            combined.append(m)
            tried.add(m)
    for m in DEFAULT_FREE_MODELS:
        if m not in tried:
            combined.append(m)
            tried.add(m)

    start_time = time.time()
    last_exc = None

    for i, model in enumerate(combined):
        # Check time budget
        elapsed = time.time() - start_time
        if elapsed > MAX_TRY_TIME:
            raise Exception(f"Time budget {MAX_TRY_TIME}s exceeded")

        try:
            return _try_openrouter(messages, model, temperature, max_tokens)
        except Exception as exc:
            last_exc = exc
            logger.warning("Model %s failed: %s", model, exc)
            # No sleep between attempts – we're already wasting time on network calls
            # But to be gentle on free tier, add a tiny delay after a 429
            if "rate limited" in str(exc).lower() or "429" in str(exc):
                time.sleep(0.3)

    raise last_exc or Exception("All models exhausted")