#!/usr/bin/env python

import os
from flask import Flask

debug = os.getenv('DEBUG', True)
host = os.getenv('HOST', '0.0.0.0')
port = os.getenv('PORT', 5000)

app = Flask(__name__)

@app.route("/")
def index():
  return "Hello World!"

if __name__ == "__main__":
  app.run(debug=debug, host=host, port=port)
