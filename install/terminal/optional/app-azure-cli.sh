#!/bin/bash

# Azure CLI - Microsoft Azure Command Line Interface
# Essential for Azure developers and cloud infrastructure management

# Add Microsoft's signing key and repository
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Azure CLI installed successfully!"
echo "Run 'az --version' to verify installation."
echo "Run 'az login' to authenticate with your Azure account."
