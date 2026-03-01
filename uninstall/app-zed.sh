#!/bin/bash

sudo apt remove --purge -y zed
sudo rm -f /etc/apt/sources.list.d/zed.list
sudo rm -f /usr/share/keyrings/zed.gpg
