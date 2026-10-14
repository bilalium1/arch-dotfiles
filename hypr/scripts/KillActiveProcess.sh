#!/usr/bin/env bash
set -euo pipefail

pid=$(hyprctl activewindow -j | jq -r '.pid')
if [[ -n "$pid" && "$pid" != "0" && "$pid" != "null" ]]; then
    kill "$pid"
fi
