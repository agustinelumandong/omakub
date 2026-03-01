#!/bin/bash

# Install Wireshark with proper permissions for non-root capture

# Install Wireshark
sudo apt install -y wireshark

# Configure Wireshark to allow non-root users to capture packets
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo dpkg-reconfigure -f noninteractive wireshark-common

# Add current user to wireshark group
sudo usermod -a -G wireshark $USER

echo "✓ Wireshark installed successfully!"
echo ""
echo "IMPORTANT: You need to log out and log back in for group changes to take effect."
echo "After logging back in, you'll be able to capture packets without root privileges."
echo ""
echo "To verify group membership after re-login, run:"
echo "  groups | grep wireshark"
