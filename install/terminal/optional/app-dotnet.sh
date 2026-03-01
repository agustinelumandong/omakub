#!/bin/bash

# Install .NET SDK 8.0 LTS
# Official Microsoft repository installation

# Add Microsoft package repository
if [ ! -f /etc/apt/sources.list.d/microsoft-prod.list ]; then
  cd /tmp
  wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm -f packages-microsoft-prod.deb
  cd -
fi

# Update package index
sudo apt update

# Install .NET SDK 8.0 LTS
sudo apt install -y dotnet-sdk-8.0

# Verify installation
if command -v dotnet &> /dev/null; then
  echo "✓ .NET SDK installed successfully!"
  dotnet --version
  echo ""
  echo "Create a new console app with:"
  echo "  dotnet new console -n MyApp"
  echo "Run it with:"
  echo "  cd MyApp && dotnet run"
else
  echo "✗ .NET SDK installation failed"
  exit 1
fi
