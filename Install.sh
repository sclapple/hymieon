#!/bin/bash

set -e

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="$(eval echo ~"$USER_NAME")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$EUID" -eq 0 ]; then
    echo "Run this script as a normal user, not root."
    exit 1
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo ":: Installing paru..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/paru.git /tmp/paru
(cd /tmp/paru && makepkg -si --noconfirm)
rm -rf /tmp/paru

echo ":: Installing packages..."
paru -S --needed --noconfirm \
    gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
    mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader lact \
    java-environment-common java-runtime-common jdk17-openjdk jre-openjdk jre8-openjdk jre8-openjdk-headless \
    jq adwsteamgtk appimagelauncher protonplus polkit-gnome gnome-disk-utility xorg-xhost snapper btrfs-assistant \
    uwsm fzf mpv fastanime fish fisher firefox nvim cron hyprfreeze-git hyprpicker \
    aic94xx-firmware ast-firmware linux-firmware-qlogic linux-firmware-bnx2x linux-firmware-liquidio \
    power-profiles-daemon linux-firmware-mellanox linux-firmware-nfp wd719x-firmware upd72020x-fw \
    steam lutris wine winetricks gamemode lib32-gamemode \
    giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 \
    openal lib32-openal v4l-utils lib32-v4l-utils libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins \
    alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite \
    libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt \
    libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs \
    obs-studio mangohud lib32-mangohud goverlay gamescope \
    bluez bluez-utils lib32-libpulse pipewire pipewire-pulse pipewire-alsa linux-headers xwaylandvideobridge \
    polychromatic openrazer-daemon transmission-gtk mpd mpc rmpc ttf-iosevka-nerd hyprsunset vesktop inotify-tools less \
    pamac-all networkmanager krabby-bin

echo ":: Copying configuration files..."
sudo cp -r "$SCRIPT_DIR/etc/." /etc/
sudo cp -r "$SCRIPT_DIR/var/." /var/
cp -r "$SCRIPT_DIR/home/." "$USER_HOME/"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config" "$USER_HOME/.local" "$USER_HOME/Wallpapers" 2>/dev/null || true

echo ":: Resolving home directory placeholders..."
grep -rl "__HOME__" "$USER_HOME" 2>/dev/null | while read -r f; do
    sed -i "s|__HOME__|$USER_HOME|g" "$f"
done

echo ":: Enabling services..."
systemctl --user enable --now mpd-mpris 2>/dev/null || true
systemctl --user enable --now mpd 2>/dev/null || true
sudo usermod -aG gamemode "$USER_NAME" 2>/dev/null || true
sudo systemctl enable fstrim.timer 2>/dev/null || true
sudo systemctl enable NetworkManager.service 2>/dev/null || true
sudo systemctl enable bluetooth.service 2>/dev/null || true
sudo systemctl enable cronie.service 2>/dev/null || true
sudo modprobe razermouse 2>/dev/null || true
sudo gpasswd -a "$USER_NAME" plugdev 2>/dev/null || true
sudo systemctl enable --now lactd 2>/dev/null || true

echo ":: Setting default shell to fish..."
echo /usr/bin/fish | sudo tee -a /etc/shells > /dev/null
sudo chsh -s /usr/bin/fish "$USER_NAME"

read -rp "Reboot now? [Y/n] " answer
case "${answer,,}" in
    n|no) echo "Done. Reboot later with: sudo reboot" ;;
    *)    sudo reboot ;;
esac
