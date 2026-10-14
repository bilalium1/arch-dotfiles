#!/usr/bin/env bash

pkill -x waybar 2>/dev/null
sleep 0.3
waybar >/dev/null 2>&1 &
disown
