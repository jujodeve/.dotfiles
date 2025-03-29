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
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
ttf-ubuntu-font-family
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
plasma
kde-application
tesseract-data-eng
kitty
"

sudo pacman -S --noconfirm --needed $PACKAGES

sudo systemctl enable gdm
