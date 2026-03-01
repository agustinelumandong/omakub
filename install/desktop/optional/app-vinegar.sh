#!/bin/bash
set -e

# Vinegar - Roblox Studio launcher for Linux (Wine-based)
# Uses Flatpak as the recommended method by developers

if ! flatpak list | grep -q "org.vinegarhq.Vinegar"; then
  flatpak install -y flathub org.vinegarhq.Vinegar
fi
