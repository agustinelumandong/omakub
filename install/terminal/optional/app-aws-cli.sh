#!/bin/bash

# AWS CLI v2 - Amazon Web Services Command Line Interface
# Essential for AWS developers and cloud infrastructure management
# Note: apt install awscli often provides v1, so we use the official installer

cd /tmp

# Check if AWS CLI v2 is already installed
if command -v aws &> /dev/null; then
  AWS_VERSION=$(aws --version 2>&1 | cut -d ' ' -f1 | cut -d '/' -f2)
  if [[ "$AWS_VERSION" == 2.* ]]; then
    echo "AWS CLI v2 is already installed: $(aws --version)"
    cd -
    exit 0
  else
    echo "AWS CLI v1 detected. Upgrading to v2..."
  fi
fi

# Download AWS CLI v2
echo "Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip
unzip -q awscliv2.zip

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
sudo ./aws/install --update

# Cleanup
rm -rf awscliv2.zip aws

echo "AWS CLI v2 installed successfully!"
echo "Run 'aws --version' to verify installation."
echo "Run 'aws configure' to set up your AWS credentials."

cd -
