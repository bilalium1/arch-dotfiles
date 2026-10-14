#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/wallpapers11"

wallpaper=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) \
    | sort | rofi -dmenu -i -p "Wallpaper")

[ -z "$wallpaper" ] && exit 0

ext="${wallpaper##*.}"
ext="${ext,,}"

if [[ "$ext" == "gif" ]]; then
    magick "$wallpaper[0]" /tmp/current_wallpaper.jpg
else
    cp -f "$wallpaper" "/tmp/current_wallpaper.$ext"
fi

awww img "$wallpaper" \
    --transition-type center \
    --transition-duration 1.5 \
    --transition-bezier 0.16,1.0,0.3,1.0

wallust run "$wallpaper" --check-contrast

bash ~/.config/hypr/gmap.sh
bash ~/.config/hypr/gmap_rose.sh
bash ~/.config/hypr/gmap_album.sh

source ~/.colors.sh
magick ~/.config/kitty/terminal.png -fill "$color6" -colorize 100% ~/.config/kitty/output.png
magick ~/Pictures/sonicthumbs.png -fill "$color6" -colorize 100% ~/Pictures/sonic_clrd.png

hyprctl notify 2 2000 0 "Wallpaper changed !                      "
