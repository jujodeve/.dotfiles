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

exit
# options
# -c cups
# -f filofem
# -g gnome
# -h chrome
# -p packages
# -s steam
# -u udev-rules
# -v virtualization
# -a all

OPTSTRING=":cfghpsuva"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    c)
      echo "Option -x was triggered, Argument: ${OPTARG}"
      ;&
    y)
      echo "Option -y was triggered, Argument: ${OPTARG}"
      ;;
    :)
      echo "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
