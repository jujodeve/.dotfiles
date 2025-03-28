#!/usr/bin/env bash

### steam install

flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user

if [[ -b "/dev/disk/by-label/jtx-nvme" ]]; then
    flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user
fi

