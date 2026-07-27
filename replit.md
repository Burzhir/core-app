# CORE App — Monorepo

AI-powered philosophical coaching app.

## Project structure

```
backend/    Flask REST API (Python)
frontend/   Flutter mobile app (Android & iOS)
```

## Backend (Flask API)

**Stack:** Python 3.12, Flask 3, Gunicorn, OpenRouter AI

**Run locally:**
```bash
cd backend
pip install -r requirements.txt
python app.py
```

**Run with Gunicorn (production-style):**
```bash
cd backend && gunicorn wsgi:app --bind 0.0.0.0:5000
```

The API is served on port **5000**.

### Required secrets
| Key | Purpose |
|-----|---------|
| `OPENROUTER_API_KEY` | AI completions via OpenRouter (required) |
| `SECRET_KEY` | Flask session secret |

### Optional env vars
| Key | Default | Purpose |
|-----|---------|---------|
| `REDIS_URL` | `memory://` | Rate-limiter storage (in-memory by default) |
| `ALLOWED_ORIGINS` | `*` | CORS allowed origins |
| `APP_URL` | `http://localhost:3000` | Sent as HTTP-Referer to OpenRouter |
| `PRIORITY_MODELS` | `deepseek/deepseek-v4-flash` | Comma-separated OpenRouter model list |

### Endpoints
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/health` | Health check |
| GET | `/api/philosophies` | List philosophies |
| POST | `/api/chat` | AI philosopher chat |
| POST | `/api/analyze` | Philosophy analysis |
| POST | `/api/maya` | Maya coaching persona |

## Frontend (Flutter)

**Stack:** Flutter, Firebase Auth, Firestore, RevenueCat (subscriptions)

**Points to backend:** `https://core-app-x3ok.onrender.com` (configured in `frontend/lib/services/ai_service.dart` and `frontend/lib/providers/`)

To point the Flutter app at the Replit backend, update `_baseUrl` in the service files to the Replit dev domain.

**Build for Android:**
```bash
cd frontend
flutter pub get
flutter build apk
```

## User preferences
- Keep existing project structure — do not restructure or migrate
