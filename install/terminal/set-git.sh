#!/bin/bash

# Set common git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true

# Set identification from install inputs or prompt interactively
if [[ -n "${OMAKUB_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$OMAKUB_USER_NAME"
else
  # Prompt for name if not set
  current_name=$(git config --global user.name)
  if [ -z "$current_name" ]; then
    read -p "Enter your full name for Git commits: " git_name
    if [ -n "$git_name" ]; then
      git config --global user.name "$git_name"
    fi
  fi
fi

if [[ -n "${OMAKUB_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$OMAKUB_USER_EMAIL"
else
  # Prompt for email if not set
  current_email=$(git config --global user.email)
  if [ -z "$current_email" ]; then
    read -p "Enter your email address for Git commits: " git_email
    if [ -n "$git_email" ]; then
      git config --global user.email "$git_email"
    fi
  fi
fi
