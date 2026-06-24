#!/usr/bin/env bash

NOTES_DIR="$HOME/Notes"
EDITOR="kitty -- nvim"

mkdir -p "$NOTES_DIR"

# List note filenames without .md, add 📄 prefix
NOTES=$(find "$NOTES_DIR" -maxdepth 1 -type f -name "*.md" -printf "%f\n" |
  sed 's/\.md$//' |
  sort |
  sed 's/^/📄 /')

# Show menu
CHOICE=$(printf "📝 New Note\n$NOTES" | rofi -dmenu -p "Markdown Notes")
[[ -z "$CHOICE" ]] && exit 0

if [[ "$CHOICE" == "📝 New Note" ]]; then
  FILENAME=$(rofi -dmenu -p "New note name (.md auto-added)")
  [[ -z "$FILENAME" ]] && exit 0

  FILEPATH="$NOTES_DIR/${FILENAME%.md}.md"
  touch "$FILEPATH"
  $EDITOR "$FILEPATH"
else
  # Strip emoji before looking up file
  BASENAME=$(echo "$CHOICE" | sed 's/^📄 //')
  $EDITOR "$NOTES_DIR/$BASENAME.md"
fi
