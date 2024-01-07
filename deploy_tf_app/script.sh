#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo apt install python3 -y
sudo apt install pip -y
pip install flask

sudo docker pull edencoania/release:hello_actions-latest
python3 /home/ubuntu/app.py


