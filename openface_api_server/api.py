import json
import subprocess

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    res = subprocess.run(["bash", "response.sh"], stdout=subprocess.PIPE)
    res = res.stdout.decode()
    data = json.loads(res)
    return jsonify(data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
