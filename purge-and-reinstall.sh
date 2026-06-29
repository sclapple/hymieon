#!/bin/bash
set -e

RED='\033[1;31m'; YELLOW='\033[1;33m'; GREEN='\033[1;32m'; NC='\033[0m'

if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}Do not run this script as root. Run as a normal user.${NC}"
    exit 1
fi

echo -e "${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║     Package Purge & Reinstall Script                     ║${NC}"
echo -e "${YELLOW}║     Removes packages NOT in Install.sh then reinstalls   ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${RED}WARNING: Do NOT reboot until the script completes successfully!${NC}"
echo ""
echo -e "${YELLOW}Proceed? (y/n)${NC}"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborted.${NC}"
    exit 1
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! command -v paru &>/dev/null; then
    echo -e "${RED}paru is required but not found.${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}[1/5] Building package lists...${NC}"

SURVIVAL_PKGS=(
    linux linux-firmware linux-headers
    btrfs-progs paru networkmanager git
    sudo bash coreutils systemd pacman glibc gcc-libs
)

USER_KEEP_PKGS=(
    gnome-boxes transmission-gtk jdk17-openjdk
    papers yad nodejs-lts-krypton
)

DESIRED_PKGS=(
    base base-devel linux linux-headers amd-ucode
    hyprland hyprcursor hyprshutdown hyprpwcenter xdg-desktop-portal-hyprland
    efibootmgr zram-generator networkmanager
    cronie git openssh greetd power-profiles-daemon
    grim cliphist wtype wl-clip-persist
    gamescope mangohud gamemode
    brightnessctl ddcutil goverlay
    pipewire
    fish kitty tmux starship fzf
    bat fd ripgrep jq yazi
    nano less fastfetch fisher
    neovim opencode
    jre8-openjdk
    chromium nautilus firefox
    steam lutris wine
    prismlauncher cosu-trainer
    audacity obs-studio kdenlive
    mpv
    loupe imagemagick
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    ttf-jetbrains-mono-nerd ttf-noto-nerd
    papirus-icon-theme
    nwg-displays nwg-look qt5ct-kde qt6ct-kde
    btrfs-assistant resources bleachbit file-roller
    cameractrls network-manager-applet
    cage pacman-contrib rbw selectdefaultapplication-git
    expac
    xdotool xorg-xwininfo
    sof-firmware upd72020x-fw v4l2loopback-dkms v4l-utils
    ntfs-3g
    samba sshfs
    rsync wget socat ethtool
    7zip
    adw-gtk-theme-git appmanager bibata-cursor-theme
    coolercontrol hyprshade keyguard
    lsfg-vk noctalia-git noctalia-greeter-git
    proton-ge-custom-bin scopebuddy spotify vesktop
    vkbasalt zen-browser-bin
    mesa vulkan-radeon
    feishin jellyfin-mpv-shim jellyfin-tui
    nodejs-lts-iron deadlock-modmanager-bin hedgemodmanager-git
    opentabletdriver osu-lazer-bin rewind-bin
    unleashedrecomp-bin upscayl
)

ALL_KEEP=("${SURVIVAL_PKGS[@]}" "${USER_KEEP_PKGS[@]}" "${DESIRED_PKGS[@]}")
printf '%s\n' "${ALL_KEEP[@]}" | sort -u > /tmp/keep_pkgs.txt
echo "  Total packages to keep/reinstall: $(wc -l < /tmp/keep_pkgs.txt)"

echo ""
echo -e "${YELLOW}[2/5] Marking keep packages as explicitly installed...${NC}"
KEPT=0
while IFS= read -r pkg; do
    if pacman -Qi "$pkg" &>/dev/null; then
        sudo pacman -D --asexplicit "$pkg" 2>/dev/null || true
        ((KEPT++)) || true
    fi
done < /tmp/keep_pkgs.txt
echo "  Marked $KEPT packages as explicit"

echo ""
echo -e "${YELLOW}[3/5] Marking unwanted packages as dependencies...${NC}"
MARKED=0
for pkg in $(pacman -Qqen 2>/dev/null; pacman -Qqem 2>/dev/null | sort -u); do
    if ! grep -qxF "$pkg" /tmp/keep_pkgs.txt; then
        sudo pacman -D --asdeps "$pkg" 2>/dev/null || true
        ((MARKED++)) || true
    fi
done
echo "  Marked $MARKED packages as dependencies"

echo ""
echo -e "${YELLOW}[3b] Removing orphaned packages...${NC}"
ORPHANS=$(pacman -Qdtq 2>/dev/null | wc -l)
echo "  Orphans to remove: $ORPHANS"
if [ "$ORPHANS" -gt 0 ]; then
    sudo pacman -Rns --noconfirm $(pacman -Qdtq 2>/dev/null) 2>/dev/null || true
fi
echo -e "${GREEN}  Done.${NC}"

echo ""
echo -e "${YELLOW}[4/5] Installing all packages from Install.sh...${NC}"
paru -S --needed --noconfirm "${DESIRED_PKGS[@]}"
echo -e "${GREEN}  All packages installed.${NC}"

echo ""
echo -e "${YELLOW}[5/5] Final orphan cleanup...${NC}"
ORPHANS2=$(pacman -Qdtq 2>/dev/null | wc -l)
if [ "$ORPHANS2" -gt 0 ]; then
    sudo pacman -Rns --noconfirm $(pacman -Qdtq 2>/dev/null) 2>/dev/null || true
fi
echo "  Remaining orphans cleaned"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Package purge and reinstall complete!                 ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Reboot now? (y/n)${NC}"
read -r reboot_response
if [[ "$reboot_response" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo -e "${YELLOW}Reboot later with: sudo reboot${NC}"
fi
