# GNOME guard (added by Pop!_OS patch)
is_gnome() { [[ "${OMAKUB_DE:-}" == *"GNOME"* ]]; }
is_gnome || { echo "  Skipping (GNOME only): app-gnome-sushi.sh"; return 0; }

#!/bin/bash

# Gives you previews in the file manager when pressing space
sudo apt install -y gnome-sushi
