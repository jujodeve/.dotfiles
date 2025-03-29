#!/usr/bin/env bash

# no autosuspend
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction = 0

# single click open item
kwriteconfig6 --file kdeglobals --group KDE --key SingleClick true

# dark theme
kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"

# katerc menu bar
kwriteconfig6 --file katerc --group General --key "Show Menu Bar" false

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
