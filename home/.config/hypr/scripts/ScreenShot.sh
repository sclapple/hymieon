#!/bin/bash

dir="$(xdg-user-dir PICTURES)/Screenshots"
mkdir -p "$dir"

time=$(date "+%d-%b_%H-%M-%S")
file="Screenshot_${time}_${RANDOM}.png"
path="$dir/$file"

grim -g "$(slurp)" - >"$path"
wl-copy <"$path"

resp=$(timeout 5 notify-send -t 10000 \
  -A action1=Open -A action2=Delete \
  " Screenshot" " Area Captured")

case "$resp" in
action1) xdg-open "$path" & ;;
action2) rm "$path" ;;
esac
