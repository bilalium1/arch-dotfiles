#!/usr/bin/env bash

theme=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
icons=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
cursor=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
size=$(gsettings get org.gnome.desktop.interface cursor-size)

hypr setcursor $cursor $size

cat > ~/.config/hypr/configs/gtk-env.conf <<EOF
env = GTK_THEME,$theme
env = GTK_ICON_THEME,$icons
env = XCURSOR_THEME,$cursor
env = XCURSOR_SIZE,$size
EOF

hyprctl reload
