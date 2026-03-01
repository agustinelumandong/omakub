#!/bin/bash

# kubectl - Kubernetes command-line tool
# Essential for managing Kubernetes clusters

if [ ! -f /etc/apt/sources.list.d/kubernetes.list ]; then
  echo "Adding Kubernetes repository..."
  
  # Add Kubernetes GPG key
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.35/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  
  # Add Kubernetes repository
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.35/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
fi

sudo apt update
sudo apt install -y kubectl

# Add kubectl completion to bashrc
if ! grep -q "kubectl completion bash" ~/.bashrc; then
  echo "# kubectl completion" >> ~/.bashrc
  echo "source <(kubectl completion bash)" >> ~/.bashrc
fi

echo "kubectl installed successfully!"
echo "Run 'kubectl version --client' to verify installation."
echo "Note: Bash completion will be available after restarting your terminal."
