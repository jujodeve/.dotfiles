
#!/usr/bin/env bash

TTC_PATH="/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/Documents/Elder Scrolls Online/live/AddOns/TamrielTradeCentre"

JTX_STEAM_PATH="/mnt/jtx-ssd/SteamLibrary"

FFM_STEAM_PATH="/home/jotix/.local/share/Steam"

if [[ "$HOSTNAME" == "jtx-arch" ]]; then
    TTC_PATH=$JTX_STEAM_PATH$TTC_PATH
else
    TTC_PATH=$FFM_STEAM_PATH$TTC_PATH
fi

curl -o ~/Downloads/PriceTable.zip 'https://us.tamrieltradecentre.com/download/PriceTable'
unzip -o ~/Downloads/PriceTable.zip -d ~/Downloads/PriceTable
cd ~/Downloads/PriceTable

rsync -auvzhPX --progress ~/Downloads/PriceTable/. "$TTC_PATH"
