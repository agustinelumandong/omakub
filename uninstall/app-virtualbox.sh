#!/bin/bash

sudo apt purge -y virtualbox-7.2
sudo apt autoremove --purge -y
rm -rf ~/.config/VirtualBox
