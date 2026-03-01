#!/bin/bash

sudo apt remove --purge -y helm
sudo rm -f /etc/apt/sources.list.d/helm-stable-debian.list
sudo rm -f /usr/share/keyrings/helm.gpg
