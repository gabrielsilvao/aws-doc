from flask import Flask, jsonify
import subprocess
import subprocess

app = Flask(__name__)

@app.route('/')
def homepage():
    return 'Hello World!'

@app.route('/terraform/instance')
def instance():
    
