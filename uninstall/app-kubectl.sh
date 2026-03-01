#!/bin/bash

sudo apt remove --purge -y kubectl
sudo rm -f /etc/apt/sources.list.d/kubernetes.list
sudo rm -f /usr/share/keyrings/kubernetes-apt-keyring.gpg
