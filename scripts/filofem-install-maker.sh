sudo echo -e '
#!/usr/bin/env bash

if [[ ! -d "/mnt/jtx-data/filofem" ]]; then
    echo "Mount the disk jtx-data in /mnt/jtx-data"
    exit
fi

tar -xf /mnt/jtx-data/filofem/mozilla.tar.xz -C $HOME

# no autosuspend
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction = 0

# localerc
kwriteconfig6 --file plasma-localerc --group Formats --key LANG "en_US.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_ADDRESS "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_MEASUREMENT "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_MONETARY "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_NAME "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_NUMERIC "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_PAPER "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_TELEPHONE "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Formats --key LC_TIME "es_AR.UTF-8"
kwriteconfig6 --file plasma-localerc --group Translations --key LANGUAGE es
' | sudo tee /home/filofem/filofem-install.sh

sudo chmod +x /home/filofem/filofem-install.sh

sudo chown filofem /home/filofem/filofem-install.sh
