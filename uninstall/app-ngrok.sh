#!/bin/bash
set -e

sudo apt remove --purge -y ngrok
sudo rm -f /etc/apt/sources.list.d/ngrok.list
sudo rm -f /etc/apt/trusted.gpg.d/ngrok.asc
sudo apt update
