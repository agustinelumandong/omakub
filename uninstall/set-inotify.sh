#!/bin/bash

sudo rm -f /etc/sysctl.d/60-inotify.conf
sudo sysctl -p
