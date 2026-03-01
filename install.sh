#!/bin/bash


# Setup logging to file while still showing output on terminal
export OMAKUB_LOG_FILE="$HOME/.local/share/omakub/install-$(date +%Y%m%d-%H%M%S).log"
mkdir -p "$(dirname "$OMAKUB_LOG_FILE")"
echo "Installation started at $(date)" | tee "$OMAKUB_LOG_FILE"
echo "Log file: $OMAKUB_LOG_FILE" | tee -a "$OMAKUB_LOG_FILE"
echo "" | tee -a "$OMAKUB_LOG_FILE"

# Redirect all output to both terminal and log file
exec > >(tee -a "$OMAKUB_LOG_FILE") 2>&1

# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
trap 'echo ""; echo "Omakub installation failed! Check log file: $OMAKUB_LOG_FILE"; echo "You can retry by running: source ~/.local/share/omakub/install.sh"' ERR
export OMAKUB_DE="${XDG_CURRENT_DESKTOP:-unknown}"

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh
source ~/.local/share/omakub/install/identification.sh

# Desktop software and tweaks will only be installed if we're running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] || [[ "$XDG_CURRENT_DESKTOP" == *"COSMIC"* ]]; then
  # Ensure computer doesn't go to sleep or lock while installing

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
else
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi

# Installation completed successfully
echo ""
echo "==============================================="
echo "✓ Omakub installation completed successfully!"
echo "==============================================="
echo ""
echo "Installation log saved to: $OMAKUB_LOG_FILE"
echo ""
echo "System information:"
echo "  OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '\"')"
echo "  Desktop: $OMAKUB_DE"
echo "  User: $OMAKUB_USER_NAME <$OMAKUB_USER_EMAIL>"
echo ""
