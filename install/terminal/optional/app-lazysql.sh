#!/bin/bash

set -e

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

# Download latest release (v0.4.8)
VERSION="0.4.8"
wget -O lazysql.tar.gz "https://github.com/jorgerojas26/lazysql/releases/download/v${VERSION}/lazysql_Linux_${ARCH}.tar.gz"

# Extract and install
tar xf lazysql.tar.gz lazysql
sudo install -m 755 lazysql /usr/local/bin/lazysql

# Cleanup
rm -f lazysql lazysql.tar.gz

cd -
