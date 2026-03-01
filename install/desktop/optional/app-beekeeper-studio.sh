#!/bin/bash
set -e

if [ ! -f /etc/apt/sources.list.d/beekeeper-studio.list ]; then
  curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key | sudo gpg --dearmor -o /usr/share/keyrings/beekeeper-studio.gpg
  echo "deb [signed-by=/usr/share/keyrings/beekeeper-studio.gpg] https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio.list
fi

sudo apt update && sudo apt install -y beekeeper-studio
