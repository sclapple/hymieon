# Install

1. Boot Arch ISO, install base system
2. Connect to internet
3. `sudo pacman -S git`
4. `git clone https://github.com/sclapple/hymieon.git`
5. `cd hymieon && ./Install.sh`
6. Reboot when prompted

# After reboot

1. `cd ~/hymieon && git push`

## If gaming extras was selected

1. Log out and back in (group changes take effect)
2. `sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="threadirqs"/' /etc/default/grub`
3. `sudo grub-mkconfig -o /boot/grub/grub.cfg`
4. Reboot

