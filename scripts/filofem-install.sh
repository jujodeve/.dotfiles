#!/usr/bin/env bash

if [[ $USERNAME != "filofem" ]];then
    echo "This is a filofem user config script, do not run it in other user!"
    exit
fi

if [[ ! -d "/mnt/jtx-data/filofem" ]]; then
    echo "Mount the disk jtx-data in /mnt/jtx-data"
    exit
fi

tar -xf /mnt/jtx-data/filofem/mozilla.tar.xz -C $HOME
