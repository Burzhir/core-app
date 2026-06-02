# app.py
from flask import Flask
from config import Config
from extensions import init_extensions

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)   # loads all the Config variables

    init_extensions(app)             # sets up CORS and rate limiter

    # Register blueprints (we'll create these in a moment)
    from blueprints.diagnose import diagnosis_bp
    from blueprints.philosophies import philosophies_bp
    from blueprints.health import health_bp
    from blueprints.chat import chat_bp
    from blueprints.analyze import analyze_bp

    app.register_blueprint(diagnosis_bp)
    app.register_blueprint(philosophies_bp)
    app.register_blueprint(health_bp)
    app.register_blueprint(chat_bp)
    app.register_blueprint(analyze_bp)

    # Simple error handlers (optional but nice)
    @app.errorhandler(404)
    def not_found(e):
        return {"error": "Endpoint not found"}, 404

    @app.errorhandler(429)
    def rate_limited(e):
        return {"error": "Too many requests"}, 429

    return app

if __name__ == "__main__":
    app = create_app()
    app.run(host="0.0.0.0", port=5000, debug=False)