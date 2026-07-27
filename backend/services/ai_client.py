import os
import time
import logging
import requests
from flask import current_app, g, has_app_context, has_request_context

logger = logging.getLogger(__name__)


def _get_primary_model() -> str:
    """Return the first model from PRIORITY_MODELS env var."""
    models = os.getenv("PRIORITY_MODELS", "deepseek/deepseek-v4-flash")
    return models.split(",")[0].strip()


def call_openrouter(
    messages: list,
    temperature: float = 0.6,
    max_tokens: int = 300
) -> dict:
    """
    Make a single, reliable call to OpenRouter using a paid model.

    Returns:
        dict with key "content" (the cleaned response text).
    """
    # ------------------------------------------------------------------
    # 1. Safely obtain configuration (works with or without Flask context)
    # ------------------------------------------------------------------
    api_key = os.getenv("OPENROUTER_API_KEY")
    if not api_key and has_app_context():
        api_key = current_app.config.get("OPENROUTER_API_KEY")
    if not api_key:
        raise ValueError("OPENROUTER_API_KEY is not set")

    referer = os.getenv("APP_URL")
    if not referer and has_app_context():
        referer = current_app.config.get("APP_URL", "http://localhost:3000")

    # Request ID for logging – only available inside a request context
    req_id = "?"
    if has_request_context():
        req_id = getattr(g, "req_id", "?")

    model = _get_primary_model()

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": referer,
        "X-Title": "CORE App",
    }

    payload = {
        "model": model,
        "messages": messages,
        "temperature": temperature,
        "max_tokens": max_tokens,
        "provider": {"allow_fallbacks": True},
    }

    # ------------------------------------------------------------------
    # 2. Make the request with a clear error that never leaks internals
    # ------------------------------------------------------------------
    start = time.time()
    try:
        resp = requests.post(
            "https://openrouter.ai/api/v1/chat/completions",
            headers=headers,
            json=payload,
            timeout=25,
        )
        resp.raise_for_status()
    except Exception:
        logger.exception("OpenRouter API call failed")  # Logs full traceback
        raise Exception("AI Service temporarily unavailable") from None

    elapsed_ms = int((time.time() - start) * 1000)
    logger.info(
        "req=%s model=%s ms=%d status=%d",
        req_id, model, elapsed_ms, resp.status_code
    )

    # ------------------------------------------------------------------
    # 3. Robust response parsing – validate structure before accessing
    # ------------------------------------------------------------------
    try:
        data = resp.json()
    except ValueError:
        logger.error("OpenRouter response is not valid JSON")
        raise Exception("AI Service returned invalid data") from None

    choices = data.get("choices")
    if not isinstance(choices, list) or len(choices) == 0:
        logger.error("Unexpected response structure: %s", data)
        raise Exception("AI Service returned unexpected data")

    content = choices[0].get("message", {}).get("content", "")
    if not content:
        logger.error("Empty content in OpenRouter response")
        raise Exception("AI Service returned empty content")

    raw = content.strip()


    if raw.startswith("```"):
    
        lines = raw.split("\n", 1)
        if len(lines) > 1:
            raw = lines[1]
        else:
            raw = ""
        # Remove trailing ``` if it exists as the very last characters
        if raw.rstrip().endswith("```"):
            # Find the last occurrence of ``` and remove it, keeping leading whitespace
            last_fence = raw.rfind("```")
            raw = raw[:last_fence].rstrip()

    return {"content": raw.strip()}