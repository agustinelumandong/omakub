# GNOME guard (added by Pop!_OS patch)
is_gnome() { [[ "${OMAKUB_DE:-}" == *"GNOME"* ]]; }
is_gnome || { echo "  Skipping (GNOME only): set-framework-text-scaling.sh"; exit 0; }

#!/bin/bash

COMPUTER_MAKER=$(sudo dmidecode -t system | grep 'Manufacturer:' | awk '{print $2}')
SCREEN_RESOLUTION=$(xrandr | grep '*+' | awk '{print $1}')

if [ "$COMPUTER_MAKER" == "Framework" ] && [ "$SCREEN_RESOLUTION" == "2256x1504" ]; then
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.8
	gsettings set org.gnome.desktop.interface cursor-size 16
	sed -i "s/size = 9/size = 7/g" ~/.config/alacritty/alacritty.toml
fi
