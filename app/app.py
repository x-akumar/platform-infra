from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return {
        "app": os.getenv("APP_NAME", "env-inspector"),
        "env": os.getenv("APP_ENV", "dev"),
        "region": os.getenv("AWS_REGION", "us-east-1")
    }

@app.route("/health")
def health():
    return {"status": "healthy"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)