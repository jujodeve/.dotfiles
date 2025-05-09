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
  'com.google.Chrome.flextop.chrome-knipfmibhjlpioflafbpemngnoncknab-Default.desktop', 
  'com.google.Chrome.desktop', 
  'org.gnome.Console.desktop',
  'org.gnome.Nautilus.desktop',
  'org.gnome.Settings.desktop',
  'com.mattjakeman.ExtensionManager.desktop',
  'org.gnome.Calculator.desktop',
  'com.valvesoftware.Steam.desktop',
  'virt-manager.desktop'
]"

dconf write /org/gnome/desktop/interface/cursor-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/icon-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"

dconf write /org/gnome/shell/enabled-extensions "[
'dash-to-dock@micxgx.gmail.com',
'apps-menu@gnome-shell-extensions.gcampax.github.com',
'tiling-assistant@leleat-on-github'
]"

# gnome-text-editor
dconf write /org/gnome/TextEditor/show-line-numbers true
dconf write /org/gnome/TextEditor/highlight-current-line true
dconf write /org/gnome/TextEditor/show-map true
dconf write /org/gnome/TextEditor/show-right-margin true
dconf write /org/gnome/TextEditor/indent-style "'space'"
dconf write /org/gnome/TextEditor/tab-width 'uint32 4'

# keyboard-layout
if [[ $HOSTNAME == "jtx-arch" ]]; then
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us+altgr-intl')]"
else
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'es')]"
fi

# default fonts
dconf write /org/gnome/desktop/interface/font-name "'Adwaita Sans 10'"
dconf write /org/gnome/desktop/interface/document-font-name "'Adwaita Sans 10'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'Adwaita Mono 10'"

# dynamic workspaces
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 4
