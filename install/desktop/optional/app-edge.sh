#!/bin/bash

# Microsoft Edge - Microsoft's Chromium-based browser
# Enterprise preference, integrates with Microsoft services

if [ ! -f /etc/apt/sources.list.d/microsoft-edge.list ]; then
  echo "Adding Microsoft Edge repository..."
  
  # Add Microsoft GPG key
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-edge.gpg
  
  # Add Microsoft Edge repository
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
fi

sudo apt update
sudo apt install -y microsoft-edge-stable

echo "Microsoft Edge installed successfully!"
