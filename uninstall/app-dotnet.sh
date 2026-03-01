#!/bin/bash

sudo apt remove --purge -y dotnet-sdk-8.0 dotnet-runtime-8.0
sudo rm -f /etc/apt/sources.list.d/microsoft-prod.list
sudo rm -f /usr/share/keyrings/microsoft.gpg
