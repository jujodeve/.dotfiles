#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(dirname $(realpath -s $0))

define(){ IFS=$'\n' read -r -d '' ${1} || true; }

define OPTIONS <<'OPTIONS_END'
Options
  -c  install cups and printer drivers
  -d  install/update ad-block throw /etc/host file
  -f  copy filofem-install.sh script in /home/filofem
  -g  install gnome and enable gdm display manager
  -n  apply gnome-settings
  -o  install google chrome
  -p  install jotix's packages
  -s  install steam
  -u  copy udev-rules to /etc/udev/rules.d
  -v  install libvirt and VM manager
  -y  install hyprland and tools
  -a  install all the above options
  -h  display this message
OPTIONS_END

define FILO_SCRIPT <<'FILO_SCRIPT_END'
#!/usr/bin/env bash

### google chrome permissions

mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons
flatpak override --user --filesystem=~/.local/share/applications --filesystem=~/.local/share/icons com.google.Chrome

### gnome settings
dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/gnome/desktop/session/idle-delay 'uint32 480'
dconf write /org/gnome/desktop/screensaver/lock-enabled false
dconf write /org/gnome/desktop/notifications/show-banners false
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
dconf write /org/gnome/Console/last-window-size '(1200, 900)'
dconf write /org/gnome/shell/favorite-apps "[
  'com.google.Chrome.flextop.chrome-knipfmibhjlpioflafbpemngnoncknab-Default.desktop',
  'com.google.Chrome.desktop',
  'org.gnome.Calculator.desktop'
]"
dconf write /org/gnome/shell/enabled-extensions "[
  'dash-to-dock@micxgx.gmail.com',
  'apps-menu@gnome-shell-extensions.gcampax.github.com',
  'tiling-assistant@leleat-on-github'
]"
dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us+altgr-intl')]"
FILO_SCRIPT_END

### install printer drivers & add printers to cups
cups-install() {
    sudo pacman -S --noconfirm --needed cups ghostscript
    sudo systemctl enable cups --now

    sudo pacman -U --noconfirm $SCRIPT_PATH/printer-drivers/*.zst

    sudo lpadmin -p XP-58 -E -v 'usb://Printer-58/USB%20Printing%20Support?serial=?' -m xprinterpos/POS-58.ppd

    if [[ $HOSTNAME == "ffm-arch" ]]; then
        sudo lpadmin -p Brother-HL1212W -E -v  "ipp://192.168.0.7/ipp/port1" -m brother-HL1200-cups-en.ppd
    fi
}

### ad-block hosts file ########################################################
ad-block-install() {
    curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee /etc/hosts
}

### filofem install maker ######################################################
filofem-install-maker() {
    echo "$FILO_SCRIPT" | sudo tee /home/filofem/filofem-install.sh

    sudo chmod +x /home/filofem/filofem-install.sh
    sudo chown filofem /home/filofem/filofem-install.sh
}

### gnome ######################################################################
gnome-install() {
    sudo pacman -S gnome gnome-extra gnome-themes-extra

    sudo systemctl enable gdm

    # gnome extension manager
    flatpak install flathub com.mattjakeman.ExtensionManager
}

### gnome settings #############################################################
gnome-settings() {
    dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true
    dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
    dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    dconf write /org/gnome/desktop/session/idle-delay 'uint32 480'
    dconf write /org/gnome/desktop/screensaver/lock-enabled false
    dconf write /org/gnome/desktop/notifications/show-banners false
    dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
    dconf write /org/gnome/Console/last-window-size '(1200, 900)'
    dconf write /org/gnome/shell/favorite-apps "[
        'com.google.Chrome.flextop.chrome-knipfmibhjlpioflafbpemngnoncknab-Default.desktop',
        'com.google.Chrome.desktop',
        'org.gnome.Console.desktop',
        'org.gnome.Nautilus.desktop',
        'com.valvesoftware.Steam.desktop',
        'org.gnome.Settings.desktop',
        'com.mattjakeman.ExtensionManager.desktop',
        'org.gnome.Calculator.desktop',
        'virt-manager.desktop'
    ]"

    dconf write /org/gnome/desktop/interface/cursor-theme "'Adwaita'"
    dconf write /org/gnome/desktop/interface/icon-theme "'Adwaita'"
    dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"

    dconf write /org/gnome/shell/enabled-extensions "[
        'dash-to-dock@micxgx.gmail.com',
        'apps-menu@gnome-shell-extensions.gcampax.github.com',
        'tiling-assistant@leleat-on-github'
    ]"
    
    # gnome-text-editor
    dconf write /org/gnome/TextEditor/show-line-numbers true
    dconf write /org/gnome/TextEditor/highlight-current-line true
    dconf write /org/gnome/TextEditor/show-map true
    dconf write /org/gnome/TextEditor/show-right-margin true
    dconf write /org/gnome/TextEditor/indent-style "'space'"
    dconf write /org/gnome/TextEditor/tab-width 'uint32 4'
    
    # keyboard-layout
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us+altgr-intl')]"
}

### google chrome ##############################################################
google-chrome-install() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    flatpak install com.google.Chrome

    mkdir -p ~/.local/share/applications
    mkdir -p ~/.local/share/icons

    flatpak override --user --filesystem=~/.local/share/applications --filesystem=~/.local/share/icons com.google.Chrome
}

### install packages
packages-install() {
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
    mesa
    xf86-video-amdgpu
    vulkan-radeon
    mpv
    pipewire
    pipewire-pulse
    otf-font-awesome
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    ttf-ubuntu-font-family
    rclone
    helix	
    "
    sudo pacman -S --noconfirm --needed $PACKAGES
}

### steam ######################################################################
steam-install() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    flatpak install com.valvesoftware.Steam
    flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user

    [[ -b "/dev/disk/by-label/jtx-nvme" ]] && flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user
}

### udev rules #################################################################
udev-rules() {
    sudo cp $SCRIPT_PATH/udev/* /etc/udev/rules.d/ -v

    ### reload rules
    sudo udevadm control --reload
    sudo udevadm trigger
}

### virtualization #############################################################
virt-install() {
    sudo pacman -S --noconfirm --ask=4 libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full

    sudo usermod -a -G libvirt jotix

    sudo systemctl enable libvirtd.service --now
}

### hyprland install ###########################################################
hyprland-install() {
    PACKAGES="
    hyprland
    hyprpaper
    hyprlock
    hyprpicker
    hyprcursor
    hyprpolkitagent
    rofi-wayland
    waybar
    kitty
    "
    sudo pacman -S --noconfirm --needed $PACKAGES
}

[[ $@ == "" ]] && echo "$OPTIONS"

OPTSTRING=":cfgnopsuvyha"

while getopts ${OPTSTRING} opt; do
    case ${opt} in
	a)
	    cups-install
        adblock-install
	    [[ $HOSTNAME == "ffm-arch" ]] && filofem-install-maker
	    gnome-install
	    gnome-settings
	    google-chrome-install
	    packages-install
	    steam-install
	    udev-rules-install
	    virt-install
	    hyprland-install
	    ;;
	c)
	    cups-install
	    ;;
    d)
        adblock-install
        ;;
	f)
	    [[ $HOSTNAME == "ffm-arch" ]] && filofem-install-maker
	    ;;
	g)
	    gnome-install
	    ;;
	n)
	    gnome-settings
	    ;;
	o)
	    google-chrome-install
	    ;;
	p)
	    packages-install
	    ;;
	s)
	    steam-install
	    ;;
	u)
	    udev-rules-install
	    ;;
	v)
	    virt-install
	    ;;
	y)
	    hyprland-install
	    ;;
	*)
	    echo "$OPTIONS"
	    ;;
    esac
done
