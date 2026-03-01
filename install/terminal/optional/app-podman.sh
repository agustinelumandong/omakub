#!/bin/bash

# Podman - Daemonless container engine (Docker alternative)
# Rootless containers, improved security, Docker-compatible CLI

sudo apt install -y podman

# Create /etc/containers/nodocker to suppress Docker compatibility warnings
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker

echo "Podman installed successfully!"
echo "Run 'podman --version' to verify installation."
echo "Podman is Docker-compatible. You can use 'podman' instead of 'docker' commands."
