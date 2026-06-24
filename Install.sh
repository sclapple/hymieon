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

echo ":: Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si --noconfirm)
rm -rf /tmp/yay

echo ":: GPU drivers..."
echo "1) AMD"
echo "2) NVIDIA"
echo "0) Skip"
read -rp "Select GPU drivers: " choice
case "$choice" in
    1)
        yay -S --noconfirm mesa vulkan-radeon
        ;;
    2)
        yay -S --noconfirm nvidia nvidia-settings opencl-nvidia
        ;;
esac

echo ":: Installing packages..."
yay -S --needed --noconfirm \
    base base-devel linux linux-headers amd-ucode \
    hyprland hyprcursor hyprshutdown hyprpwcenter xdg-desktop-portal-hyprland \
    efibootmgr zram-generator networkmanager \
    cronie git openssh greetd power-profiles-daemon \
    grim cliphist wtype wl-clip-persist \
    gamescope mangohud gamemode \
    brightnessctl ddcutil goverlay \
    pipewire \
    fish kitty tmux starship fzf \
    bat fd ripgrep jq yazi \
    nano less fastfetch fisher \
    neovim opencode \
    jre8-openjdk \
    chromium nautilus firefox \
    steam lutris wine \
    prismlauncher cosu-trainer \
    audacity obs-studio kdenlive \
    mpv \
    loupe imagemagick \
    noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ttf-jetbrains-mono-nerd ttf-noto-nerd \
    papirus-icon-theme \
    nwg-displays nwg-look qt5ct-kde qt6ct-kde \
    btrfs-assistant resources bleachbit file-roller \
    cameractrls network-manager-applet \
    cage pacman-contrib rbw selectdefaultapplication-git \
    expac \
    xdotool xorg-xwininfo \
    sof-firmware upd72020x-fw v4l2loopback-dkms v4l-utils \
    ntfs-3g \
    samba sshfs \
    rsync wget socat ethtool \
    7zip \
    adw-gtk-theme-git appmanager bibata-cursor-theme \
    coolercontrol hyprshade keyguard \
    lsfg-vk noctalia-git \
    proton-ge-custom-bin scopebuddy spotify vesktop \
    vkbasalt zen-browser-bin

echo ":: Optional extras..."
read -rp "Install Jellyfin things? (jellyfin-tui, feishin, jellyfin-mpv-shim) [y/N] " answer
case "${answer,,}" in
    y|yes)
        yay -S --noconfirm feishin jellyfin-mpv-shim jellyfin-tui
        ;;
esac

GAMING_EXTRAS=false
read -rp "Install gaming extras? (deadlock-modmanager-bin, hedgemodmanager-git, opentabletdriver, osu-lazer-bin, rewind-bin, unleashedrecomp-bin, upscayl) [y/N] " answer
case "${answer,,}" in
    y|yes)
        GAMING_EXTRAS=true
        yay -S --noconfirm deadlock-modmanager-bin hedgemodmanager-git opentabletdriver osu-lazer-bin rewind-bin unleashedrecomp-bin upscayl
        echo ":: Applying audio latency tuning..."
        sudo tee /etc/security/limits.d/99-audio.conf > /dev/null <<'EOF'
@audio   -   rtprio   95
@audio   -   memlock  unlimited
EOF
        sudo usermod -aG audio "$USER_NAME"
        ;;
esac

echo ":: Copying configuration files..."
sudo cp -r "$SCRIPT_DIR/etc/." /etc/
sudo cp -r "$SCRIPT_DIR/var/." /var/
cp -r "$SCRIPT_DIR/home/." "$USER_HOME/"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config" "$USER_HOME/.local" "$USER_HOME/Wallpapers" 2>/dev/null || true

echo ":: Resolving home directory placeholders..."
grep -rl "__HOME__" "$USER_HOME" 2>/dev/null | while read -r f; do
    sed -i "s|__HOME__|$USER_HOME|g" "$f"
done

if [ "$GAMING_EXTRAS" != true ]; then
    echo ":: Skipping pipewire/wireplumber configs (no gaming extras)..."
    rm -rf "$USER_HOME/.config/pipewire" "$USER_HOME/.config/wireplumber"
fi

echo ":: Enabling services..."
sudo usermod -aG gamemode "$USER_NAME" 2>/dev/null || true
sudo systemctl enable fstrim.timer 2>/dev/null || true
sudo systemctl enable NetworkManager.service 2>/dev/null || true
sudo systemctl enable bluetooth.service 2>/dev/null || true
sudo systemctl enable cronie.service 2>/dev/null || true
sudo systemctl enable greetd.service 2>/dev/null || true
sudo systemctl enable --now coolercontrold 2>/dev/null || true
sudo gpasswd -a "$USER_NAME" plugdev 2>/dev/null || true

echo ":: Setting default shell to fish..."
echo /usr/bin/fish | sudo tee -a /etc/shells > /dev/null
sudo chsh -s /usr/bin/fish "$USER_NAME"

read -rp "Reboot now? [Y/n] " answer
case "${answer,,}" in
    n|no) echo "Done. Reboot later with: sudo reboot" ;;
    *)    sudo reboot ;;
esac
