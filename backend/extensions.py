from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
cors = CORS()

def init_extensions(app):
    limiter.init_app(app)
    cors.init_app(app, origins=app.config["ALLOWED_ORIGINS"])