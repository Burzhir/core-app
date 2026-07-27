import uuid
import logging
from flask import Flask, g
from config import Config
from extensions import init_extensions
from utils.logging_config import setup_logging
from utils.errors import error_response
from werkzeug.middleware.proxy_fix import ProxyFix

logger = logging.getLogger(__name__)


def create_app():
    # 1. Create the app once
    app = Flask(__name__)

    # 2. Load configuration
    app.config.from_object(Config)
    app.config['MAX_CONTENT_LENGTH'] = 16 * 1024  # 16 KB

    # 3. Apply ProxyFix so rate limiter sees the real client IP
    app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1)

    # 4. Set up logging (now that config is available)
    setup_logging()

    # 5. Initialize extensions (CORS, rate limiter, etc.)
    init_extensions(app)

    # 6. Startup configuration validation
    if not app.config.get("OPENROUTER_API_KEY"):
        logger.error(
            "OPENROUTER_API_KEY is not set — AI endpoints will return fallback responses"
        )
    if app.config.get("SECRET_KEY") == "a-very-strong-secret-key":
        logger.warning(
            "SECRET_KEY is using the insecure default — set SECRET_KEY env var in production"
        )

    # 7. Register blueprints
    from blueprints.philosophies import philosophies_bp
    from blueprints.health import health_bp
    from blueprints.chat import chat_bp
    from blueprints.analyze import analyze_bp
    from blueprints.maya_route import maya_bp

    app.register_blueprint(philosophies_bp)
    app.register_blueprint(health_bp)
    app.register_blueprint(chat_bp)
    app.register_blueprint(analyze_bp)
    app.register_blueprint(maya_bp)

    # 8. Request‑level middleware
    @app.before_request
    def assign_request_id():
        g.req_id = str(uuid.uuid4())[:8]

    # 9. Error handlers
    @app.errorhandler(404)
    def not_found(e):
        return error_response("Endpoint not found", 404, "NOT_FOUND")

    @app.errorhandler(405)
    def method_not_allowed(e):
        return error_response("Method not allowed", 405, "METHOD_NOT_ALLOWED")

    @app.errorhandler(429)
    def rate_limited(e):
        return error_response("Too many requests. Slow down.", 429, "RATE_LIMITED")

    @app.errorhandler(500)
    def server_error(e):
        logger.exception("Unhandled exception")
        return error_response("Internal server error", 500, "SERVER_ERROR")

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(host="0.0.0.0", port=5000, debug=False)