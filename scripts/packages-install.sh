#!/usr/bin/env bash

### install packages ##########################################################
PACKAGES="
arch-install-scripts
exfat-utils
dosfstools
base-devel
cmake
fish
less
man-pages
man-db
exa
bat
lsb-release
usbutils
git
lazygit
openssh
fastfetch
neovim
emacs
mesa
xf86-video-amdgpu
vulkan-radeon
mpv
firefox
chromium
hyprland 
hyprpaper
hyprlock
hyprpicker
hyprcursor
hyprpolkitagent
rofi-wayland 
waybar 
kitty
pipewire
pipewire-pulse
wireplumber
otf-font-awesome
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
ttf-ubuntu-font-family
"

sudo pacman -S --noconfirm --needed $PACKAGES

