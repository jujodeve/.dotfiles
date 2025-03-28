#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))

set -e

# install packages
$SCRIPT_PATH/packages-install.sh

# gnome extension manager
$SCRIPT_PATH/extension-manager-install.sh

# gnome-settings
$SCRIPT_PATH/gnome-settings.sh

# printers
$SCRIPT_PATH/cups-install.sh

# virtualization
$SCRIPT_PATH/virt-install.sh

# steam
$SCRIPT_PATH/steam-install.sh

# udev rules
$SCRIPT_PATH/udev-rules-install.sh

# powerline-go
$SCRIPT_PATH/powerline-go-install.sh

# copy filofem script
sudo cp $SCRIPT_PATH/filofem-install.sh /home/filofem/
sudo chown filofem /home/filofem/filofem-install.sh

