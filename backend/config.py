import os
from dotenv import load_dotenv

load_dotenv()   # loads the .env file into environment variables

class Config:
    SECRET_KEY = os.getenv("SECRET_KEY", "a-very-strong-secret-key")
    REDIS_URL = os.getenv("REDIS_URL", "memory://")          # rate limit storage
    ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "http://localhost:3000").split(",")
    OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")     # required
    APP_URL = os.getenv("APP_URL", "http://localhost:3000")

    # Model rotation settings
    OPENROUTER_MODELS = os.getenv("OPENROUTER_MODELS")       # comma-separated full list (optional, overrides built-in)
    PRIORITY_MODELS = os.getenv("PRIORITY_MODELS")           # comma-separated priority list
    MAX_AI_TRY_TIME = float(os.getenv("MAX_AI_TRY_TIME", "7.0"))  # seconds