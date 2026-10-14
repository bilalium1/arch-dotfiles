#!/usr/bin/env bash
set -euo pipefail

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/Screenshot_$(date +'%Y%m%d_%H%M%S').png"

grim -g "$(slurp)" - | tee "$file" | wl-copy
