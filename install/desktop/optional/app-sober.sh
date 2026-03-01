#!/bin/bash
set -e

# Sober - Roblox game client for Linux (Android runtime)
# Uses Flatpak as the only official distribution method

if ! flatpak list | grep -q "org.vinegarhq.Sober"; then
  flatpak install -y flathub org.vinegarhq.Sober
fi
