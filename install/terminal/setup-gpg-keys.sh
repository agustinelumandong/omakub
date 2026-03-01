#!/bin/bash

# Interactive GPG key setup for signing commits and encryption

echo "==================================="
echo "GPG Key Setup for Git & Encryption"
echo "==================================="
echo ""

# Check if GPG keys already exist
if gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then
  echo "✓ Existing GPG keys found:"
  gpg --list-secret-keys --keyid-format=long
  echo ""
  
  REUSE=$(gum choose "Use existing key" "Generate new key" --header "GPG keys already exist. What would you like to do?")
  
  if [ "$REUSE" = "Use existing key" ]; then
    echo ""
    echo "Please select the key to use for Git signing:"
    KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep "sec" | awk '{print $2}' | cut -d'/' -f2 | gum choose --header "Select GPG key")
    
    if [ -n "$KEY_ID" ]; then
      git config --global user.signingkey "$KEY_ID"
      git config --global commit.gpgsign true
      git config --global tag.gpgsign true
      
      echo ""
      echo "✓ Git configured to sign commits with key: $KEY_ID"
      echo ""
      echo "To add this key to GitHub/GitLab:"
      echo "1. Copy your public key:"
      echo "   gpg --armor --export $KEY_ID | pbcopy"
      echo "2. Add to GitHub: Settings → SSH and GPG keys → New GPG key"
      echo "3. Add to GitLab: Preferences → GPG Keys → Add new key"
    fi
    
    return 0
  fi
fi

# Generate new GPG key
echo "Generating new GPG key..."
echo ""

# Get user information (use collected values or prompt)
if [ -n "$OMAKUB_USER_NAME" ] && [ -n "$OMAKUB_USER_EMAIL" ]; then
  GPG_NAME="$OMAKUB_USER_NAME"
  GPG_EMAIL="$OMAKUB_USER_EMAIL"
  echo "Using previously collected information:"
  echo "  Name: $GPG_NAME"
  echo "  Email: $GPG_EMAIL"
  echo ""
else
  GPG_NAME=$(gum input --placeholder "Full Name (e.g., John Doe)" --header "Enter your full name")
  GPG_EMAIL=$(gum input --placeholder "Email (e.g., john@example.com)" --header "Enter your email address")
fi

if [ -z "$GPG_NAME" ] || [ -z "$GPG_EMAIL" ]; then
  echo "✗ Name and email are required. Exiting."
  exit 1
fi

# Select key type
KEY_TYPE=$(gum choose "RSA 4096" "Ed25519 (modern)" --header "Select key type")

if [ "$KEY_TYPE" = "Ed25519 (modern)" ]; then
  KEY_ALGO="ed25519"
  KEY_LENGTH=""
else
  KEY_ALGO="rsa"
  KEY_LENGTH="4096"
fi

# Set expiration
EXPIRATION=$(gum choose "No expiration" "1 year" "2 years" "5 years" --header "Key expiration")

case "$EXPIRATION" in
  "1 year")
    EXPIRE="1y"
    ;;
  "2 years")
    EXPIRE="2y"
    ;;
  "5 years")
    EXPIRE="5y"
    ;;
  *)
    EXPIRE="0"
    ;;
esac

# Generate key configuration
if [ "$KEY_ALGO" = "ed25519" ]; then
  GPG_CONFIG="Key-Type: EDDSA
Key-Curve: Ed25519
Subkey-Type: ECDH
Subkey-Curve: Curve25519
Name-Real: $GPG_NAME
Name-Email: $GPG_EMAIL
Expire-Date: $EXPIRE
%no-protection
%commit"
else
  GPG_CONFIG="Key-Type: RSA
Key-Length: $KEY_LENGTH
Subkey-Type: RSA
Subkey-Length: $KEY_LENGTH
Name-Real: $GPG_NAME
Name-Email: $GPG_EMAIL
Expire-Date: $EXPIRE
%no-protection
%commit"
fi

echo ""
echo "Generating GPG key (this may take a moment)..."
echo "$GPG_CONFIG" | gpg --batch --generate-key

# Get the new key ID
KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$GPG_EMAIL" | grep "sec" | awk '{print $2}' | cut -d'/' -f2 | head -n1)

if [ -z "$KEY_ID" ]; then
  echo "✗ Failed to generate GPG key"
  exit 1
fi

# Configure Git to use the new key
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true
git config --global tag.gpgsign true

echo ""
echo "✓ GPG key generated successfully!"
echo "  Key ID: $KEY_ID"
echo ""
echo "To add this key to GitHub/GitLab:"
echo "1. Copy your public key:"
echo "   gpg --armor --export $KEY_ID"
echo ""
echo "2. Add to GitHub:"
echo "   Settings → SSH and GPG keys → New GPG key"
echo ""
echo "3. Add to GitLab:"
echo "   Preferences → GPG Keys → Add new key"
echo ""


# Ensure ~/.ssh directory exists before exporting public key
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

# Export public key
gpg --armor --export "$KEY_ID" > ~/.ssh/gpg-public-key.asc
echo "✓ Public key exported to: ~/.ssh/gpg-public-key.asc"
