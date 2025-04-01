#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))

set -e

# install packages
$SCRIPT_PATH/packages-install.sh

# printers
$SCRIPT_PATH/cups-install.sh

# virtualization
$SCRIPT_PATH/virt-install.sh

# steam
$SCRIPT_PATH/steam-install.sh

# udev rules
$SCRIPT_PATH/udev-rules-install.sh

# copy filofem script
if [[ $HOSTNAME == "ffm-arch" ]]; then
  $SCRIPT_PATH/filofem-install-maker.sh
fi
