#!/bin/bash

sudo apt remove --purge -y microsoft-edge-stable
sudo rm -f /etc/apt/sources.list.d/microsoft-edge.list
sudo rm -f /usr/share/keyrings/microsoft-edge.gpg
