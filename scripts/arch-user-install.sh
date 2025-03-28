#!/usr/bin/env bash

set -e

if [[ ! -d /mnt/jtx-data/jotix/ ]]; then
    echo "No disk mounted in /mnt/jtx-data"
    exit
fi

tar -xf /mnt/jtx-data/jotix/mozilla.tar.xz -C $HOME

tar -xf /mnt/jtx-data/jotix/jotix.tar.xz -C $HOME

mkdir -p ~/workspace

git clone git@gitlab.com:jotix/arch-config $HOME/workspace/arch-config

$HOME/workspace/arch-config/scripts/jotix-install.sh

