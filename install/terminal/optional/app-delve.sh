#!/bin/bash

# Install Delve - Go debugger
# Requires Go to be installed first

# Check if Go is installed
if ! command -v go &> /dev/null; then
  echo "✗ Go is not installed. Please install Go first:"
  echo "  Select 'Go' in the programming languages menu during Omakub setup"
  exit 1
fi

# Install Delve using go install
go install github.com/go-delve/delve/cmd/dlv@latest

# Verify installation
if [ -f "$HOME/go/bin/dlv" ]; then
  echo "✓ Delve installed successfully!"
  echo "  Delve binary: $HOME/go/bin/dlv"
  echo ""
  echo "Usage:"
  echo "  dlv debug        # Debug main package"
  echo "  dlv test         # Debug tests"
  echo "  dlv attach <pid> # Attach to running process"
  echo ""
  echo "Make sure $HOME/go/bin is in your PATH"
else
  echo "✗ Delve installation failed"
  exit 1
fi
