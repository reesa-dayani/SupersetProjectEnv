SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")
SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY", "fallback-secret-key")

DEBUG = True



FEATURE_FLAGS = {
    "ALLOW_FILE_UPLOAD": True
    
}
