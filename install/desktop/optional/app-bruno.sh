#!/bin/bash

# Bruno - Fast, Git-friendly open-source API client
# Lightweight alternative to Postman with offline-first approach

BRUNO_VERSION="3.1.4"
BRUNO_DEB="bruno_${BRUNO_VERSION}_amd64_linux.deb"
BRUNO_URL="https://github.com/usebruno/bruno/releases/download/v${BRUNO_VERSION}/${BRUNO_DEB}"

cd /tmp

# Download Bruno .deb
if [ ! -f "$BRUNO_DEB" ]; then
  echo "Downloading Bruno ${BRUNO_VERSION}..."
  wget "$BRUNO_URL"
fi

# Install Bruno
echo "Installing Bruno..."
sudo apt install -y "./$BRUNO_DEB"

# Cleanup
rm -f "$BRUNO_DEB"

echo "Bruno ${BRUNO_VERSION} installed successfully!"

cd -
