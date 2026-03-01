#!/usr/bin/env bash
# COSMIC desktop settings — replaces set-gnome-settings.sh on Pop!_OS COSMIC
# Settings are stored as RON files in ~/.config/cosmic/

COSMIC_CONFIG="$HOME/.config/cosmic"

# Dark mode
mkdir -p "$COSMIC_CONFIG/com.system76.CosmicTheme.Dark/v1"
printf '(is_dark: true,)\n' \
  > "$COSMIC_CONFIG/com.system76.CosmicTheme.Dark/v1/active"

# Natural scrolling for touchpad
mkdir -p "$COSMIC_CONFIG/com.system76.CosmicInput/v1"
printf '(true)\n' \
  > "$COSMIC_CONFIG/com.system76.CosmicInput/v1/scroll_natural_scroll_touchpad"

# Monospace font — JetBrainsMono Nerd Font (installed by omakub terminal step)
mkdir -p "$COSMIC_CONFIG/com.system76.CosmicFont/v1"
printf '("JetBrainsMono Nerd Font", 12.0)\n' \
  > "$COSMIC_CONFIG/com.system76.CosmicFont/v1/monospace_font"

# Auto-tiling on (this is COSMIC's killer feature)
mkdir -p "$COSMIC_CONFIG/com.system76.CosmicComp/v1"
printf '(true)\n' \
  > "$COSMIC_CONFIG/com.system76.CosmicComp/v1/autotile"
printf '(PerWorkspace)\n' \
  > "$COSMIC_CONFIG/com.system76.CosmicComp/v1/autotile_behavior"

# GTK4 dark preference (affects libadwaita apps)
mkdir -p "$HOME/.config/gtk-4.0"
cat > "$HOME/.config/gtk-4.0/settings.ini" << 'INI'
[Settings]
gtk-application-prefer-dark-theme=true
INI

# GTK3 dark preference
mkdir -p "$HOME/.config/gtk-3.0"
cat > "$HOME/.config/gtk-3.0/settings.ini" << 'INI'
[Settings]
gtk-application-prefer-dark-theme=1
INI

echo "COSMIC settings applied (dark mode, auto-tiling, fonts)."
echo "Re-login required for some settings to take effect."
