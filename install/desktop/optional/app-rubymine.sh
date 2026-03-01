#!/usr/bin/env bash
# JetBrains Toolbox — install this, then get RubyMine/PhpStorm from within it
# Pop!_OS patch: replaced store install with direct download
TOOLBOX_URL="https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
curl -fsSL "$TOOLBOX_URL" -o /tmp/toolbox.tar.gz
tar -xzf /tmp/toolbox.tar.gz -C /tmp
/tmp/jetbrains-toolbox-*/jetbrains-toolbox