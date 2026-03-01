#!/bin/bash

set -e

# lazynpm requires Node.js and npm
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
  echo "Warning: lazynpm requires Node.js and npm. Install Node.js first."
  exit 1
fi

cd /tmp

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x86_64"
elif [ "$ARCH" = "aarch64" ]; then
  ARCH="arm64"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

# Download latest release (v0.1.4)
VERSION="0.1.4"
wget -O lazynpm.tar.gz "https://github.com/jesseduffield/lazynpm/releases/download/v${VERSION}/lazynpm_${VERSION}_Linux_${ARCH}.tar.gz"

# Extract and install
tar xf lazynpm.tar.gz lazynpm
sudo install -m 755 lazynpm /usr/local/bin/lazynpm

# Cleanup
rm -f lazynpm lazynpm.tar.gz

cd -
