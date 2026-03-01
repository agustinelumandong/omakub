#!/bin/bash

# Terraform - Infrastructure as Code tool by HashiCorp
# Essential for infrastructure automation and cloud provisioning

if [ ! -f /etc/apt/sources.list.d/hashicorp.list ]; then
  echo "Adding HashiCorp repository..."
  
  # Add HashiCorp GPG key
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  
  # Add HashiCorp repository
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
fi

sudo apt update
sudo apt install -y terraform

# Enable autocomplete
terraform -install-autocomplete 2>/dev/null || true

echo "Terraform installed successfully!"
echo "Run 'terraform --version' to verify installation."
