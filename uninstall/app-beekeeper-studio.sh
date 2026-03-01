#!/bin/bash
set -e

sudo apt remove --purge -y beekeeper-studio
sudo rm -f /etc/apt/sources.list.d/beekeeper-studio.list
sudo rm -f /usr/share/keyrings/beekeeper-studio.gpg
sudo apt update
