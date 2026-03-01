#!/bin/bash

# Interactive SSH key generation setup
# Essential for GitHub/GitLab authentication and remote server access

echo "SSH Key Generation Setup"
echo "========================"
echo ""

# Check if SSH directory exists
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

# Check for existing SSH keys
if [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]; then
  echo "Existing SSH keys found:"
  ls -la "$HOME/.ssh" | grep "^-" | awk '{print $9}' | grep -E "(id_|\.pub$)"
  echo ""
  
  read -p "Do you want to generate a new SSH key? (y/n): " generate_new
  if [ "$generate_new" != "y" ]; then
    echo "Skipping SSH key generation."
    exit 0
  fi
fi

# Prompt for email
read -p "Enter your email address (for SSH key comment): " email

if [ -z "$email" ]; then
  echo "Email is required. Exiting."
  exit 1
fi

# Prompt for key type
echo ""
echo "Select SSH key type:"
echo "1) Ed25519 (recommended, modern, secure)"
echo "2) RSA 4096 (compatible with older systems)"
read -p "Choice [1]: " key_type

key_type=${key_type:-1}

# Generate SSH key based on selection
if [ "$key_type" == "2" ]; then
  echo "Generating RSA 4096-bit SSH key..."
  ssh-keygen -t rsa -b 4096 -C "$email" -f "$HOME/.ssh/id_rsa"
  key_file="$HOME/.ssh/id_rsa.pub"
else
  echo "Generating Ed25519 SSH key..."
  ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519"
  key_file="$HOME/.ssh/id_ed25519.pub"
fi

# Start SSH agent and add key
echo ""
echo "Starting SSH agent and adding key..."
eval "$(ssh-agent -s)"

if [ "$key_type" == "2" ]; then
  ssh-add "$HOME/.ssh/id_rsa"
else
  ssh-add "$HOME/.ssh/id_ed25519"
fi

# Display public key
echo ""
echo "=========================================="
echo "Your SSH public key (copy this to GitHub/GitLab):"
echo "=========================================="
cat "$key_file"
echo "=========================================="
echo ""
echo "To add this key to GitHub:"
echo "1. Go to https://github.com/settings/keys"
echo "2. Click 'New SSH key'"
echo "3. Paste the key above"
echo ""
echo "To add this key to GitLab:"
echo "1. Go to https://gitlab.com/-/profile/keys"
echo "2. Paste the key above"
echo ""
echo "SSH key setup complete!"
