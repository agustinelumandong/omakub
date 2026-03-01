#!/bin/bash

# Install Firefox browser using Mozilla's official APT repository
# This prevents Ubuntu from forcing Firefox Snap installation
# See: https://support.mozilla.org/en-US/kb/install-firefox-linux

# Add Mozilla's APT repository GPG key
if [ ! -f /etc/apt/keyrings/packages.mozilla.org.asc ]; then
  echo "Adding Mozilla APT repository..."
  sudo install -d -m 0755 /etc/apt/keyrings
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
fi

# Add Mozilla APT repository
if [ ! -f /etc/apt/sources.list.d/mozilla.list ]; then
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null
fi

# Configure APT to prioritize Mozilla repository over Ubuntu's Snap transition package
if [ ! -f /etc/apt/preferences.d/mozilla ]; then
  echo "Setting APT pinning to prevent Snap transition..."
  cat << 'EOF' | sudo tee /etc/apt/preferences.d/mozilla > /dev/null
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
fi

# Install Firefox
sudo apt update
sudo apt install -y firefox

echo "Firefox installed successfully from Mozilla's official repository!"
