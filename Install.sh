sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ~ && git clone https://github.com/javalsai/lidm.git && cd lidm && sudo make && sudo make install-service-systemd && cd ~ && yay -S --needed --noconfirm gvfs thunar-archive-plugin thunar-media-tags-plugin thunar-volman \
	java-environment-common java-runtime-common jdk17-openjdk jq jre-openjdk \
       	jre8-openjdk jre8-openjdk-headless adwsteamgtk appimagelauncher mangohud \
       	goverlay steam wine-staging winetricks gamemode lib32-gamemode giflib lib32-giflib \
       	libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 \
       	openal lib32-openal v4l-utils lib32-v4l-utils libgpg-error lib32-libgpg-error \
       	alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
       	sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama \
       	ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt \
       	libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs \
       	vulkan-icd-loader lib32-vulkan-icd-loader obs-studio discord mangohud lib32-mangohud \
       	goverlay gamescope solaar bluez bluez-utils lib32-libpulse pipewire pipewire-pulse \
       	pipewire-alsa linux-headers xwaylandvideobridge protonplus polkit-gnome gnome-disk-utility \
	timeshift xorg-xhost uwsm fzf fastanime mpv fish \
 	mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader \
       	pamac-all networkmanager lidm && sudo usermod -aG gamemode damieon && sudo systemctl enable fstrim.timer && sudo systemctl enable NetworkManager && sudo systemctl enable lidm.service && sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Arch-Hyprland/main/auto-install.sh)
