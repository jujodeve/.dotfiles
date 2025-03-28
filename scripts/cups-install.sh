#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))

### install printer drivers & add printers to cups

sudo pacman -S --noconfirm --needed cups ghostscript
sudo systemctl enable cups --now

sudo pacman -U --noconfirm $SCRIPT_PATH/printer-drivers/*.zst

sudo lpadmin -p XP-58 -E -v 'usb://Printer-58/USB%20Printing%20Support?serial=?' -m xprinterpos/POS-58.ppd

if [[ $HOSTNAME == "ffm-arch" ]]; then
    sudo lpadmin -p Brother-HL1212W -E -v  "ipp://192.168.0.7/ipp/port1" -m brother-HL1200-cups-en.ppd 
fi

