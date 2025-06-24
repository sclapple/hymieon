sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ~ && git clone https://github.com/javalsai/lidm.git && cd lidm && sudo make && sudo make install-service-systemd && cd ~ && yay -S --needed --noconfirm gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
	java-environment-common java-runtime-common jdk17-openjdk jq jre-openjdk \
       	jre8-openjdk jre8-openjdk-headless adwsteamgtk appimagelauncher \
       	steam wallust protonplus polkit-gnome gnome-disk-utility \
	xorg-xhost grub-btrfs timeshift timeshift-autosnap uwsm fzf fastanime mpv fish fisher polychromatic openrazer-daemon opentabletdriver cosu-trainer-bin lact \
  	aic94xx-firmware ast-firmware linux-firmware-qlogic linux-firmware-bnx2x linux-firmware-liquidio power-profiles-daemon \
   	linux-firmware-mellanox linux-firmware-nfp wd719x-firmware upd72020x-fw cava firefox \
       	pamac-all networkmanager lidm && sudo usermod -aG gamemode damieon && sudo systemctl enable fstrim.timer && sudo systemctl enable NetworkManager.service && sudo systemctl enable lidm.service && sudo modprobe razermouse && sudo gpasswd -a $USER plugdev && sudo systemctl enable --now lactd && echo /usr/bin/fish | sudo tee -a /etc/shells && chsh -s /usr/bin/fish && fish && set -U fish_greeting
