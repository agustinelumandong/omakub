#!/bin/bash

sudo apt remove --purge -y azure-cli
sudo rm -f /etc/apt/sources.list.d/azure-cli.list
sudo rm -f /usr/share/keyrings/microsoft.gpg
