#!/usr/bin/env sh

# Configuration
FALLBACK_IMAGE="$HOME/.config/mpd/default_cover.jpg"
TMP_DIR="/tmp/mpd_notify"
mkdir -p "$TMP_DIR"

# Holds last song's hash
LAST_HASH=""

# Notification function
send_notification() {
  ARTIST=$(playerctl metadata artist 2>/dev/null)
  TITLE=$(playerctl metadata title 2>/dev/null)
  COVER_URL=$(playerctl metadata mpris:artUrl 2>/dev/null)

  # Convert file:// URL to file path
  if echo "$COVER_URL" | grep -q '^file://'; then
    COVER_PATH=$(printf '%b' "${COVER_URL#file://}")
  else
    COVER_PATH="$FALLBACK_IMAGE"
  fi

  [ -f "$COVER_PATH" ] || COVER_PATH="$FALLBACK_IMAGE"

  notify-send -i "$COVER_PATH" "Now Playing" "$ARTIST - $TITLE"
}

# Loop with deduplication
playerctl --player=mpd metadata --follow --format '{{ artist }} - {{ title }}' | while read -r current; do
  [ -z "$current" ] && continue

  CURRENT_HASH=$(echo "$current" | md5sum | cut -d' ' -f1)

  if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
    send_notification
    LAST_HASH="$CURRENT_HASH"
  fi
done
