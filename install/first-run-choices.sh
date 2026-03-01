#!/bin/bash

# Only ask for default desktop app choices when running Gnome or COSMIC
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] || [[ "$XDG_CURRENT_DESKTOP" == *"COSMIC"* ]]; then
  OPTIONAL_APPS=("1password" "Spotify" "Zoom" "Dropbox" "Firefox" "Postman" "Peek" "Font-Manager" "Bruno" "Chromium" "Edge" "Terraform" "Kubectl" "Helm" "AWS-CLI" "Azure-CLI" "Podman" "Azure-Storage-Explorer" "Htop" "BleachBit" "Wireshark" "USBGuard" "JetBrains-Toolbox" "Eclipse" "Dotnet" "Delve" "Slack" "Teams" "Zed" "LazyNPM" "LazySQL" "Beekeeper-Studio" "Ngrok" "YouTube-Music" "Sober" "Vinegar")
  DEFAULT_OPTIONAL_APPS='1password,Spotify,Zoom,Firefox,Terraform,Kubectl'
  export OMAKUB_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 36 --header "Select optional apps" | tr ' ' '-')
fi

AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
SELECTED_LANGUAGES="Python,Node.js,PHP"
export OMAKUB_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="MySQL,Redis,PostgreSQL"
export OMAKUB_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")

# Collect user information for Git, GPG, and SSH configuration
export OMAKUB_USER_NAME=$(gum input --placeholder "Your Full Name" --header "Enter your full name for Git commits")
export OMAKUB_USER_EMAIL=$(gum input --placeholder "your.email@example.com" --header "Enter your email address")
