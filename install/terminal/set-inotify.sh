#!/bin/bash

# Increase inotify max_user_watches to prevent "too many open files" errors
# This is essential for Node.js/React development, Dropbox, and other file-watching tools
# Ubuntu 24.04 default is 8192, which is too low for modern development

INOTIFY_CONFIG="/etc/sysctl.d/60-inotify.conf"

if [ ! -f "$INOTIFY_CONFIG" ]; then
  echo "Setting inotify max_user_watches to 524288..."
  echo "fs.inotify.max_user_watches=524288" | sudo tee "$INOTIFY_CONFIG" > /dev/null
  
  # Apply the change immediately without rebooting
  sudo sysctl -p "$INOTIFY_CONFIG"
  
  echo "inotify configuration applied successfully!"
else
  echo "inotify configuration already exists at $INOTIFY_CONFIG"
fi
