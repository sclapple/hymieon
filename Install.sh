#!/bin/bash
set -e

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}Do not run this script as root. Run as a normal user.${NC}"
    exit 1
fi

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME="$(eval echo ~"$USER_NAME")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GAMING_EXTRAS=false

install_yay() {
    if ! command -v yay &> /dev/null; then
        echo -e "${YELLOW}Installing yay-bin...${NC}"
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        (cd /tmp/yay-bin && makepkg -si --noconfirm)
        rm -rf /tmp/yay-bin
    else
        echo -e "${GREEN}yay is already installed.${NC}"
    fi
}

install_amd() {
    echo -e "${YELLOW}Installing AMD GPU drivers...${NC}"
    yay -S --noconfirm mesa vulkan-radeon
    echo -e "${GREEN}AMD GPU drivers installed.${NC}"
}

install_nvidia() {
    echo -e "${YELLOW}Installing NVIDIA GPU drivers...${NC}"
    yay -S --noconfirm nvidia nvidia-settings opencl-nvidia
    echo -e "${GREEN}NVIDIA GPU drivers installed.${NC}"
}

install_main() {
    echo -e "${YELLOW}Installing packages...${NC}"
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
        lsfg-vk noctalia-git noctalia-greeter-git \
        proton-ge-custom-bin scopebuddy spotify vesktop \
        vkbasalt zen-browser-bin
    echo -e "${GREEN}Main packages installed.${NC}"
}

copy_configs() {
    echo -e "${YELLOW}Copying configuration files...${NC}"
    sudo cp -r "$SCRIPT_DIR/etc/." /etc/
    sudo cp -r "$SCRIPT_DIR/var/." /var/
    cp -r "$SCRIPT_DIR/home/." "$USER_HOME/"
    chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config" "$USER_HOME/.local" "$USER_HOME/Wallpapers" 2>/dev/null || true

    echo -e "${YELLOW}Resolving home directory placeholders...${NC}"
    grep -rl "__HOME__" "$USER_HOME" 2>/dev/null | while read -r f; do
        sed -i "s|__HOME__|$USER_HOME|g" "$f"
    done

    if [ "$GAMING_EXTRAS" != true ]; then
        echo -e "${YELLOW}Skipping pipewire/wireplumber configs (no gaming extras)...${NC}"
        rm -rf "$USER_HOME/.config/pipewire" "$USER_HOME/.config/wireplumber"
    fi
}

ensure_xdg_dirs() {
    echo -e "${YELLOW}Ensuring XDG user directories exist...${NC}"
    if [ -f "$USER_HOME/.config/user-dirs.dirs" ]; then
        grep -oP '^XDG_[A-Z_]+_DIR="\K[^"]+' "$USER_HOME/.config/user-dirs.dirs" | while read -r dir; do
            expanded_dir=$(eval echo "$dir")
            mkdir -p "$expanded_dir"
        done
    fi
    mkdir -p "$USER_HOME/.local/share"
    chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config" "$USER_HOME/.local" 2>/dev/null || true
}

enable_services() {
    echo -e "${YELLOW}Enabling services...${NC}"
    sudo usermod -aG gamemode "$USER_NAME" 2>/dev/null || true
    sudo systemctl enable fstrim.timer 2>/dev/null || true
    sudo systemctl enable NetworkManager.service 2>/dev/null || true
    sudo systemctl enable bluetooth.service 2>/dev/null || true
    sudo systemctl enable cronie.service 2>/dev/null || true
    sudo useradd -r -s /usr/bin/nologin -d /var/lib/noctalia-greeter greeter 2>/dev/null || true
    sudo chown -R greeter:greeter /var/lib/noctalia-greeter 2>/dev/null || true
    sudo systemctl enable greetd.service 2>/dev/null || true
    sudo systemctl enable --now coolercontrold 2>/dev/null || true
    sudo gpasswd -a "$USER_NAME" plugdev 2>/dev/null || true
}

set_shell() {
    echo -e "${YELLOW}Setting default shell to fish...${NC}"
    echo /usr/bin/fish | sudo tee -a /etc/shells > /dev/null
    sudo chsh -s /usr/bin/fish "$USER_NAME"
}

# Main flow
echo -e "${YELLOW}This script will configure your system with Hyprland/Noctalia and install software.${NC}"
echo -e "${YELLOW}Proceed? (y/n)${NC}"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborted.${NC}"
    exit 1
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

install_yay

echo -e "${YELLOW}Install AMD GPU drivers? (y/n)${NC}"
read -r amd_response
if [[ "$amd_response" =~ ^[Yy]$ ]]; then
    install_amd
fi

echo -e "${YELLOW}Install NVIDIA GPU drivers? (y/n)${NC}"
read -r nvidia_response
if [[ "$nvidia_response" =~ ^[Yy]$ ]]; then
    install_nvidia
fi

install_main

echo -e "${YELLOW}Install Jellyfin things? (feishin, jellyfin-mpv-shim, jellyfin-tui) (y/n)${NC}"
read -r jellyfin_response
if [[ "$jellyfin_response" =~ ^[Yy]$ ]]; then
    yay -S --noconfirm feishin jellyfin-mpv-shim jellyfin-tui
fi

echo -e "${YELLOW}Install gaming extras? (deadlock-modmanager-bin, hedgemodmanager-git, opentabletdriver, osu-lazer-bin, rewind-bin, unleashedrecomp-bin, upscayl) (y/n)${NC}"
read -r gaming_response
if [[ "$gaming_response" =~ ^[Yy]$ ]]; then
    GAMING_EXTRAS=true
    echo -e "${YELLOW}Switching to nodejs-lts-iron for opentabletdriver...${NC}"
    sudo pacman -Rdd nodejs --noconfirm 2>/dev/null || true
    yay -S --noconfirm nodejs-lts-iron
    yay -S --noconfirm deadlock-modmanager-bin hedgemodmanager-git opentabletdriver osu-lazer-bin rewind-bin unleashedrecomp-bin upscayl
    echo -e "${YELLOW}Applying audio latency tuning...${NC}"
    sudo tee /etc/security/limits.d/99-audio.conf > /dev/null <<'EOF'
@audio   -   rtprio   95
@audio   -   memlock  unlimited
EOF
    sudo usermod -aG audio "$USER_NAME"
fi

copy_configs
ensure_xdg_dirs
enable_services
set_shell

echo -e "${GREEN}Installation complete. Reboot now? (y/n)${NC}"
read -r reboot_response
if [[ "$reboot_response" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo -e "${YELLOW}Reboot later with: sudo reboot${NC}"
fi
