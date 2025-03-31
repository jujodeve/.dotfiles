#!/usr/bin/env bash

sudo pacman -S gnome gnome-extra

sudo systemctl enable gdm

# gnome extension manager
flatpak install flathub com.mattjakeman.ExtensionManager

