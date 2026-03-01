#!/bin/bash

# Interactive SSH key generation setup
# Essential for GitHub/GitLab authentication and remote server access

echo "SSH Key Generation Setup"
echo "========================"
echo ""

# Ask if user wants to set up SSH keys
setup_choice=$(gum choose "Set up SSH keys now" "Skip SSH setup" --header "Do you want to set up SSH keys?")

if [ "$setup_choice" = "Skip SSH setup" ]; then
  echo "Skipping SSH key setup. You can run this script later if needed."
  return 0
fi
echo "SSH keys are used for GitHub/GitLab authentication and remote server access."
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
  
  generate_choice=$(gum choose "Use existing keys" "Generate new SSH key" --header "Existing SSH keys found. What would you like to do?")
  if [ "$generate_choice" = "Use existing keys" ]; then
    echo "Using existing SSH keys."
    return 0
  fi
fi

# Use collected email or prompt for it
if [ -n "$OMAKUB_USER_EMAIL" ]; then
  email="$OMAKUB_USER_EMAIL"
  echo "Using previously collected email: $email"
  echo ""
else
  email=$(gum input --placeholder "Enter your email address for SSH key comment")
fi

if [ -z "$email" ]; then
  echo "Email is required. Exiting."
  exit 1
fi

# Prompt for key type
echo ""
key_type_choice=$(gum choose "Ed25519 (recommended, modern, secure)" "RSA 4096 (compatible with older systems)" --header "Select SSH key type")

# Determine key type from choice

# Generate SSH key based on selection
if [[ "$key_type_choice" == *"RSA"* ]]; then
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
