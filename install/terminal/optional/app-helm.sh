#!/bin/bash

# Helm - Kubernetes package manager
# Simplifies deployment and management of applications on Kubernetes

if [ ! -f /usr/share/keyrings/helm.gpg ]; then
  echo "Adding Helm repository..."
  
  # Add Helm GPG key
  curl https://baltocdn.com/helm/signing.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  
  # Install apt-transport-https if not present
  sudo apt-get install -y apt-transport-https
  
  # Add Helm repository
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
fi

sudo apt update
sudo apt install -y helm

echo "Helm installed successfully!"
echo "Run 'helm version' to verify installation."
