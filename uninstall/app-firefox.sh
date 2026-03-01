#!/bin/bash

sudo apt remove --purge -y firefox
sudo rm -f /etc/apt/sources.list.d/mozilla.list
sudo rm -f /usr/share/keyrings/packages.mozilla.org.asc
sudo rm -f /etc/apt/preferences.d/mozilla-firefox
