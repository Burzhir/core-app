import os
from dotenv import load_dotenv

load_dotenv()   # loads the .env file into environment variables

class Config:
    SECRET_KEY = os.getenv("SECRET_KEY", "a-very-strong-secret-key")
    REDIS_URL = os.getenv("REDIS_URL", "memory://")          # rate limit storage
    ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*").split(",")
    OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")     # required
    APP_URL = os.getenv("APP_URL", "http://localhost:3000")
    PRIORITY_MODELS = os.getenv("PRIORITY_MODELS", "deepseek/deepseek-v4-flash")