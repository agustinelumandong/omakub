#!/bin/bash

# Install Eclipse IDE for Java Developers
# Uses Flatpak for easy installation and updates

# Check if Java is installed (Eclipse requires Java 17+)
if ! command -v java &> /dev/null; then
  echo "Java not found. Installing OpenJDK 21..."
  sudo apt install -y openjdk-21-jdk
fi

# Verify Java version
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 17 ]; then
  echo "Eclipse requires Java 17 or higher. Installing OpenJDK 21..."
  sudo apt install -y openjdk-21-jdk
fi

# Install Eclipse via Flatpak
flatpak install -y flathub org.eclipse.Java

echo "✓ Eclipse IDE installed successfully!"
echo "  Launch with: flatpak run org.eclipse.Java"
echo "  Or search for 'Eclipse' in your application menu"
