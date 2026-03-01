#!/bin/bash

# Check if git config already has user info set
CURRENT_GIT_NAME=$(git config --global user.name 2>/dev/null || true)
CURRENT_GIT_EMAIL=$(git config --global user.email 2>/dev/null || true)

# Only prompt if both are not already set
if [ -z "$CURRENT_GIT_NAME" ] || [ -z "$CURRENT_GIT_EMAIL" ]; then
  echo "Enter identification for git and autocomplete..."
  SYSTEM_NAME=$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)
  
  # Use existing values as defaults if available
  if [ -z "$CURRENT_GIT_NAME" ]; then
    export OMAKUB_USER_NAME=$(gum input --placeholder "Enter full name" --value "$SYSTEM_NAME" --prompt "Name> ")
  else
    export OMAKUB_USER_NAME="$CURRENT_GIT_NAME"
    echo "Name> $CURRENT_GIT_NAME (from git config)"
  fi
  
  if [ -z "$CURRENT_GIT_EMAIL" ]; then
    export OMAKUB_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
  else
    export OMAKUB_USER_EMAIL="$CURRENT_GIT_EMAIL"
    echo "Email> $CURRENT_GIT_EMAIL (from git config)"
  fi
else
  # Use existing git config values
  export OMAKUB_USER_NAME="$CURRENT_GIT_NAME"
  export OMAKUB_USER_EMAIL="$CURRENT_GIT_EMAIL"
  echo "Using existing git configuration:"
  echo "  Name: $CURRENT_GIT_NAME"
  echo "  Email: $CURRENT_GIT_EMAIL"
fi
