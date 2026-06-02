import os
from dotenv import load_dotenv

load_dotenv()   # loads the .env file into environment variables

class Config:
    SECRET_KEY = os.getenv("SECRET_KEY", "a-very-strong-secret-key")
    REDIS_URL = os.getenv("REDIS_URL", "memory://")  # rate limit storage (memory is fine for now)
    ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "http://localhost:3000").split(",")
    OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
    OPENROUTER_MODEL = os.getenv("OPENROUTER_MODEL", "qwen/qwen3-32b:free")
    APP_URL = os.getenv("APP_URL", "http://localhost:3000")