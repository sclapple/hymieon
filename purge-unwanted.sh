#!/bin/bash
set -e

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
USER_HOME="$HOME"

# Step 1: Extract all packages from Install.sh's paru/pacman -S lines
extract_script_pkgs() {
    python3 -c "
import re
with open('$SCRIPT_DIR/Install.sh') as f:
    content = f.read()

pkg_lines = []
in_block = False
for line in content.split(chr(10)):
    stripped = line.strip()
    if re.match(r'^(paru|yay|sudo pacman)\s+-S', stripped):
        in_block = True
        cmd_removed = re.sub(r'^(paru|yay|sudo pacman)\s+-S.*?(?:--noconfirm|--needed)\s*', '', stripped)
        cmd_removed = cmd_removed.rstrip('\\\\').strip()
        if cmd_removed:
            pkg_lines.append(cmd_removed)
    elif in_block and stripped:
        cmd_removed = stripped.rstrip('\\\\').strip()
        if cmd_removed and not cmd_removed.startswith(chr(35)):
            pkg_lines.append(cmd_removed)
        if not stripped.endswith('\\\\'):
            in_block = False
    elif in_block and not stripped:
        in_block = False

all_pkgs = set()
noise = {'yay','paru','pacman','sudo','\\\"\\\"','\\\"','--needed','--noconfirm',
         '--noconfirm\\\"','\\\"-S','-S\\\"','read','echo','fi','then','else','if',
         'do','done','for','while','true','||','tee','usermod','systemctl',
         'chown','chsh','gpasswd','useradd','rm','cp','mkdir','pwd','dirname',
         'eval','source','command','which','cd','kill','exit','sleep','grep',
         'sed','&&','gpasswd',chr(36)+'USER_NAME',chr(36)+'USER_HOME',
         chr(36)+'SCRIPT_DIR',chr(36)+'GAMING_EXTRAS','2>/dev/null'}

for line in pkg_lines:
    for pkg in line.split():
        pkg = pkg.strip('\\\"').strip(\"'\\\\\")
        if pkg and re.match(r'^[a-zA-Z0-9][a-zA-Z0-9\\-_+.@]*[a-zA-Z0-9+.]?$', pkg):
            if pkg not in noise and len(pkg) > 1:
                all_pkgs.add(pkg)

# Add conditional packages that are actual package names
conditionals = {'mesa','vulkan-radeon','nvidia','nvidia-settings','opencl-nvidia',
                'feishin','jellyfin-mpv-shim','jellyfin-tui',
                'deadlock-modmanager-bin','hedgemodmanager-git','opentabletdriver',
                'osu-lazer-bin','rewind-bin','unleashedrecomp-bin','upscayl','nodejs-lts-iron'}
all_pkgs.update(conditionals)
# Remove false positives
for junk in {'GPU','drivers','clone',chr(36)+'USER_NAME'}:
    all_pkgs.discard(junk)

for p in sorted(all_pkgs):
    print(p)
" 2>/dev/null || {
    echo -e "${RED}Failed to extract packages from Install.sh${NC}" >&2
    exit 1
}
}

echo -e "${YELLOW}=== Package Purge Script ===${NC}"
echo ""
echo "This script will:"
echo "  1. Extract all packages from Install.sh"
echo "  2. Add essential base system packages"
echo "  3. Remove ANY explicitly installed package not in the keep list"
echo ""

# Extract packages
echo -e "${YELLOW}Extracting packages from Install.sh...${NC}"
SCRIPT_PKGS=$(extract_script_pkgs)
SCRIPT_COUNT=$(echo "$SCRIPT_PKGS" | wc -l)
echo -e "${GREEN}Found $SCRIPT_COUNT packages in Install.sh${NC}"

# Step 2: Build the keep list
# Script packages
KEEP_LIST="$SCRIPT_PKGS"

# Essential base packages (not explicitly listed in the script but required)
ESSENTIAL="base
base-devel
bash
coreutils
glibc
gcc-libs
pacman
sudo
systemd
linux-firmware
pacman-contrib"
KEEP_LIST=$(printf "%s\n%s" "$KEEP_LIST" "$ESSENTIAL" | sort -u)

# User-requested keeps
USER_KEEPS="paru
gnome-boxes
papers
transmission-gtk"
KEEP_LIST=$(printf "%s\n%s" "$KEEP_LIST" "$USER_KEEPS" | sort -u)

# Step 3: Get currently explicitly installed packages
CURRENT_EXPLICIT=$(pacman -Qeq 2>/dev/null | sort)
CURRENT_COUNT=$(echo "$CURRENT_EXPLICIT" | wc -l)

echo -e "${YELLOW}Currently explicit packages: $CURRENT_COUNT${NC}"

# Step 4: Find packages to remove (in current but NOT in keep list)
TO_REMOVE=$(comm -23 <(echo "$CURRENT_EXPLICIT") <(echo "$KEEP_LIST"))
REMOVE_COUNT=$(echo "$TO_REMOVE" | wc -l)

echo -e "${YELLOW}Packages to remove: $REMOVE_COUNT${NC}"
echo ""
echo -e "${RED}=== PACKAGES TO BE REMOVED ===${NC}"
echo "$TO_REMOVE"
echo ""
echo -e "${RED}Total: $REMOVE_COUNT packages will be removed.${NC}"
echo -e "${YELLOW}Packages in Install.sh ($SCRIPT_COUNT) + essential base + your keeps will be kept.${NC}"
echo ""

if [ "$REMOVE_COUNT" -eq 0 ]; then
    echo -e "${GREEN}Nothing to remove!${NC}"
    exit 0
fi

echo -e "${RED}WARNING: This will remove $REMOVE_COUNT packages from your system.${NC}"
echo -e "${YELLOW}Proceed? (y/N)${NC}"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Aborted.${NC}"
    exit 1
fi

echo -e "${YELLOW}Proceed? Type 'yes' to confirm:${NC}"
read -r confirm
if [ "$confirm" != "yes" ]; then
    echo -e "${YELLOW}Aborted.${NC}"
    exit 1
fi

echo -e "${YELLOW}Removing packages...${NC}"
echo "$TO_REMOVE" | sudo pacman -Rns --noconfirm - 2>&1 || true

echo ""
echo -e "${GREEN}Done. Remaining explicit packages:${NC}"
pacman -Qeq | wc -l
echo ""
echo -e "${YELLOW}Now run ./Install.sh to reinstall everything fresh.${NC}"
