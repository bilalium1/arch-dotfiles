#!/usr/bin/env bash

case "${1:-}" in
    --inc) brightnessctl set +10% ;;
    --dec) brightnessctl set 10%- ;;
    *) echo "Usage: $0 --inc|--dec" >&2; exit 1 ;;
esac
