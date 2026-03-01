#!/bin/bash

set -e

# USBGuard - USB device authorization policy framework
# Protects against rogue USB devices (e.g., BadUSB attacks)

echo "⚠️  WARNING: USBGuard will create a policy allowing ONLY currently-connected USB devices."
echo "   Any USB devices not currently plugged in (keyboards, mice, security keys, etc.)"
echo "   will be BLOCKED on next boot until manually authorized."
echo ""
echo "   If you use hardware security keys for login, insert them NOW before proceeding."
echo ""
read -p "Do you want to continue with USBGuard installation? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "USBGuard installation cancelled."
  exit 0
fi

# Install USBGuard and utilities
sudo apt install -y usbguard usbutils udisks2 usbview

# Generate initial policy from currently connected devices
sudo systemctl enable usbguard.service --now
sudo systemctl start usbguard.service
sleep 2
sudo systemctl stop usbguard.service

# Add current user to plugdev group for IPC access
sudo usermod -a -G plugdev $USER

# Start USBGuard service
sudo systemctl restart usbguard.service

echo ""
echo "✓ USBGuard installed successfully!"
echo ""
echo "Policy created for currently connected USB devices."
echo "Any new USB devices will be BLOCKED by default."
echo ""
echo "Useful commands:"
echo "  sudo usbguard list-devices        # List all USB devices"
echo "  sudo usbguard list-devices -b     # List blocked devices"
echo "  sudo usbguard allow-device <id> -p # Permanently allow device"
echo "  sudo usbview                       # Graphical USB device viewer"
echo ""
echo "⚠️  Log out and back in for group changes to take effect."
echo "📝 Review policy: sudo nano /etc/usbguard/rules.conf"
