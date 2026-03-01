#!/bin/bash
set -e

cd /tmp

if ! dpkg -s youtube-music &>/dev/null; then
  wget -O youtube-music.deb "https://github.com/pear-devs/pear-desktop/releases/download/v3.11.0/youtube-music_3.11.0_amd64.deb"
  sudo apt install -y ./youtube-music.deb
  rm youtube-music.deb
fi

cd -
