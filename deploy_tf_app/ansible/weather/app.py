import datetime
from flask import Flask, request, render_template, redirect
import requests
import subprocess

app = Flask(__name__)


@app.route("/")
def index():
    """
    get get method with '/' url.
    """
   # run_command("sudo docker pull edencoania/release:latest")
    return run_command("sudo docker run edencoania/release:hello_actions-latest")   
    #return render_template('index.html')


def run_command(command):
    return subprocess.Popen(command, shell=True, stdout=subprocess.PIPE).stdout.read()

run_command("sudo docker pull edencoania/release:latest")

#@app.route('/<command>')
#def command_server(command):
#    return run_command(command)


if __name__ == "__main__":
    app.run(host="0.0.0.0")

