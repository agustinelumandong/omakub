#!/bin/bash
# JetBrains Toolbox uninstall (app-rubymine.sh installs Toolbox, not RubyMine SNAP)

rm -rf ~/.local/share/JetBrains/Toolbox
rm -f ~/.local/share/applications/jetbrains-toolbox.desktop
rm -f /usr/local/bin/jetbrains-toolbox
