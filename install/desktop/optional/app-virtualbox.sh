#!/bin/bash

# VirtualBox allows you to run VMs for other flavors of Linux or even Windows
# See https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview
# for a guide on how to run Ubuntu inside it.

# Using official .deb package from VirtualBox website for better compatibility
# The apt version (virtualbox, virtualbox-ext-pack) can have issues with Ubuntu 24.04

VBOX_VERSION="7.2.6"
VBOX_BUILD="172322"
VBOX_DEB="virtualbox-7.2_${VBOX_VERSION}-${VBOX_BUILD}~Ubuntu~noble_amd64.deb"
VBOX_URL="https://download.virtualbox.org/virtualbox/${VBOX_VERSION}/${VBOX_DEB}"

cd /tmp

# Download VirtualBox .deb
if [ ! -f "$VBOX_DEB" ]; then
  echo "Downloading VirtualBox ${VBOX_VERSION}..."
  wget "$VBOX_URL"
fi

# Install VirtualBox
echo "Installing VirtualBox..."
sudo apt install -y "./$VBOX_DEB"

# Add current user to vboxusers group
sudo usermod -aG vboxusers "${USER}"

# Cleanup
rm -f "$VBOX_DEB"

echo "VirtualBox ${VBOX_VERSION} installed successfully!"
echo "Note: You may need to log out and log back in for group membership to take effect."

cd -
