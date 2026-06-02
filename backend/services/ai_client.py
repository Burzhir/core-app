import os, time, json, re, requests, logging
from flask import g

logger = logging.getLogger(__name__)

def ask_openrouter(
    text: str = "",
    system_prompt: str = "",
    messages: list = None,
    temperature: float = 0.6,
    max_tokens: int = 300,
    json_mode: bool = False
) -> dict:
    # ... headers unchanged ...
    if messages is None:
        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": text},
        ]
    payload = {
        "model": os.getenv("OPENROUTER_MODEL", "qwen/qwen3-32b:free"),
        "messages": messages,
        "temperature": temperature,
        "max_tokens": max_tokens,
        "provider": {"allow_fallbacks": True},
    }
    if json_mode:
        payload["response_format"] = {"type": "json_object"}

    start = time.time()
    resp = requests.post(
        "https://openrouter.ai/api/v1/chat/completions",
        headers=headers,
        json=payload,
        timeout=45,
    )
    elapsed_ms = int((time.time() - start) * 1000)
    req_id = getattr(g, "req_id", "?")
    logger.info("req=%s openrouter_ms=%d status=%d", req_id, elapsed_ms, resp.status_code)

    if resp.status_code != 200:
        raise Exception(f"OpenRouter Error {resp.status_code}: {resp.text}")

    data = resp.json()
    raw = data["choices"][0]["message"]["content"].strip()
    # Remove markdown fences
    if raw.startswith("```"):
        raw = raw.replace("```json", "").replace("```", "").strip()
    try:
        return json.loads(raw) if json_mode else {"raw_response": raw}
    except json.JSONDecodeError:
        if json_mode:
            match = re.search(r"\{.*\}", raw, re.DOTALL)
            if match:
                return json.loads(match.group())
            raise ValueError(f"Invalid JSON: {raw}")
        return {"raw_response": raw}