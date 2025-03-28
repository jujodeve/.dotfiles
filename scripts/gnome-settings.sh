#!/usr/bin/env bash

dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/session/idle-delay 'uint32 480'
dconf write /org/gnome/desktop/screensaver/lock-enabled false
dconf write /org/gnome/desktop/notifications/show-banners false
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
dconf write /org/gnome/Console/last-window-size '(1200, 900)'
dconf write /org/gnome/shell/favorite-apps "[
    'firefox.desktop',
    'org.gnome.Console.desktop',
    'emacs.desktop',
    'org.gnome.Nautilus.desktop',
    'com.valvesoftware.Steam.desktop',
    'org.gnome.Settings.desktop',
    'com.mattjakeman.ExtensionManager.desktop',
    'org.gnome.Calculator.desktop',
    'virt-manager.desktop'
]"

dconf write /org/gnome/desktop/interface/cursor-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/icon-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita'"

dconf write /org/gnome/shell/enabled-extensions "[
    'dash-to-dock@micxgx.gmail.com',
    'apps-menu@gnome-shell-extensions.gcampax.github.com',
    'tiling-assistant@leleat-on-github'
]"

dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us+altgr-intl')]"

