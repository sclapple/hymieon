#!/usr/bin/env bash

SETTINGS="$HOME/.local/state/noctalia/settings.toml"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
WALLPAPER_DIR="$XDG_DATA_HOME/hypr/Wallpapers"
CURRENT="$WALLPAPER_DIR/current_wallpaper.png"
wallpaper=$(grep -A1 '^\s*\[wallpaper\.default\]' "$SETTINGS" | tail -1 | sed 's/.*path = "\(.*\)"/\1/')

if [[ -n "$wallpaper" && -f "$wallpaper" ]]; then
  mkdir -p "$WALLPAPER_DIR"
  ln -sf "$wallpaper" "$CURRENT" || true
fi
