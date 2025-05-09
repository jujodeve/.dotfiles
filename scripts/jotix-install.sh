#!/usr/bin/env bash

set -e

this_file_path() {
    echo $(dirname $(realpath -s $0))
}

. $(this_file_path)/functions.sh

### INSTALL PACKAGES ##########################################################
PACKAGES="
arch-install-scripts exfat-utils dosfstools
cmake fish less man-pages man-db
exa bat lsb-release usbutils git lazygit
openssh fastfetch neovim
mesa xf86-video-amdgpu vulkan-radeon mpv
otf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd
ttf-ubuntu-font-family adobe-source-code-pro-fonts
rclone flatpak
pipewire pipewire-pulse
cups ghostscript
libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full
gnome gnome-extra gnome-themes-extra
"
install_if_missing $PACKAGES

sudo pacman -U --noconfirm --needed $(this_file_path)/printer-drivers/*.zst

### ENABLING SERVICES #########################################################
# enable bluetooth
sudo systemctl enable bluetooth.service --now
# enable sddm
sudo systemctl enable gdm
# enable cups
sudo systemctl enable cups --now
# virtualization
sudo usermod -a -G libvirt jotix
sudo systemctl enable libvirtd.service --now

### ADDING PRINTERS ###########################################################
sudo lpadmin -p XP-58 -E -v \
    'usb://Printer-58/USB%20Printing%20Support?serial=?' \
    -m xprinterpos/POS-58.ppd

[[ $HOSTNAME == "ffm-arch" ]] && sudo lpadmin -p Brother-HL1212W -E -v  \
    "ipp://192.168.0.7/ipp/port1" -m brother-HL1200-cups-en.ppd

### UCEV RULES ################################################################
sudo cp $(this_file_path)/udev/* /etc/udev/rules.d/ -v

### reload rules
sudo udevadm control --reload
sudo udevadm trigger

### STEAM #####################################################################
flatpak install com.valvesoftware.Steam

[[ -d "/mnt/arch-data" ]] && flatpak override \
    --filesystem=/mnt/jtx-data com.valvesoftware.Steam --user

### MINION ####################################################################
flatpak install gg.minion.Minion

[[ -d "/mnt/arch-data" ]] && flatpak override \
    --filesystem=/mnt/jtx-data gg.minion.Minion --user

### GOOGLE-CHROME #############################################################
flatpak install com.google.Chrome
flatpak override --filesystem=/home/jotix com.google.Chrome --user

# gnome extension manager
flatpak install flathub com.mattjakeman.ExtensionManager
