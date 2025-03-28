#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))

sudo cp $SCRIPT_PATH/udev/* /etc/udev/rules.d/ -v

### reload rules
sudo udevadm control --reload
sudo udevadm trigger

