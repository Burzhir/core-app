
import uuid
import logging
from flask import Flask
from flask import g
from config import Config
from extensions import init_extensions
from utils.logging_config import setup_logging
from utils.errors import error_response

logger = logging.getLogger(__name__)

def create_app():
    setup_logging()  # Configure logging with request ID support
    app = Flask(__name__)
    app.config.from_object(Config)   # loads all the Config variables
    app.config['MAX_CONTENT_LENGTH'] = 16 * 1024  # 16 KB

    init_extensions(app)             # sets up CORS and rate limiter

    # Register blueprints (we'll create these in a moment)
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

    # Simple error handlers (optional but nice)
    @app.errorhandler(404)
    def not_found(e):
        return {"error": "Endpoint not found"}, 404

    @app.errorhandler(429)
    def rate_limited(e):
        return {"error": "Too many requests"}, 429
    
    @app.before_request
    def assign_request_id():
        g.req_id = str(uuid.uuid4())[:8]

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