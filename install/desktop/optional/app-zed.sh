#!/bin/bash

set -e

# Zed - Fast, modern code editor built in Rust
# High-performance, collaborative editing with native LSP support

if [ ! -f /etc/apt/sources.list.d/zed.list ]; then
  echo "Adding Zed repository..."
  
  # Add Zed GPG key
  curl -fsSL https://zed.dev/api/releases/stable/latest/gpg_key | sudo gpg --dearmor -o /usr/share/keyrings/zed-archive-keyring.gpg
  
  # Add Zed repository
  echo "deb [signed-by=/usr/share/keyrings/zed-archive-keyring.gpg arch=amd64] https://zed.dev/api/releases/stable/latest/deb stable main" | sudo tee /etc/apt/sources.list.d/zed.list
fi

sudo apt update
sudo apt install -y zed

echo "Zed installed successfully!"
echo "Run 'zed' from terminal or launch from applications menu."
