# GNOME guard (added by Pop!_OS patch)
is_gnome() { [[ "${OMAKUB_DE:-}" == *"GNOME"* ]]; }
is_gnome || { echo "  Skipping (GNOME only): set-gnome-theme.sh"; return 0; }

#!/bin/bash

source ~/.local/share/omakub/themes/tokyo-night/gnome.sh
source ~/.local/share/omakub/themes/tokyo-night/tophat.sh
