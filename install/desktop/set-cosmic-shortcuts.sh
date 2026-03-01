#!/usr/bin/env bash
# COSMIC keyboard shortcuts — Pop!_OS patch
# Most shortcuts are already built into COSMIC; this adds custom ones.

COSMIC_COMP="$HOME/.config/cosmic/com.system76.CosmicComp/v1"
mkdir -p "$COSMIC_COMP"

cat > "$COSMIC_COMP/custom_keybindings" << 'RON'
[
    (
        description: "Open Terminal",
        key: Key(key: E, mods: Super),
        action: System(OpenTerminal),
    ),
    (
        description: "Launch App Picker",
        key: Key(key: Space, mods: Super),
        action: System(AppLibrary),
    ),
]
RON

echo "COSMIC keyboard shortcuts configured."
echo "Built-in shortcuts reference:"
echo "  Super            App launcher"
echo "  Super+Y          Toggle auto-tiling"
echo "  Super+1..9       Switch workspace"
echo "  Super+Shift+1..9 Move window to workspace"
echo "  Super+M          Maximize window"
