#!/bin/bash
set -e

echo "This will remove packages not in your Install.sh:"
echo "  btrfs-progs hyprmod jdk17-openjdk ttf-iosevka-nerd yad"
echo ""
echo "Keep paru, gnome-boxes, papers, transmission-gtk."
echo "Proceed? (y/n)"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo pacman -Rns --noconfirm btrfs-progs hyprmod jdk17-openjdk ttf-iosevka-nerd yad

echo "Done. These packages have been removed."
