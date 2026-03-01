# GNOME guard (added by Pop!_OS patch)
is_gnome() { [[ "${OMAKUB_DE:-}" == *"GNOME"* ]]; }
is_gnome || { echo "  Skipping (GNOME only): app-gnome-tweak-tool.sh"; return 0; }

#!/bin/bash

sudo apt install -y gnome-tweak-tool
