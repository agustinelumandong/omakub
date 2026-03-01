#!/bin/bash
set -e

if [ ! -f /etc/apt/sources.list.d/ngrok.list ]; then
  curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
  echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" | sudo tee /etc/apt/sources.list.d/ngrok.list
fi

sudo apt update && sudo apt install -y ngrok
