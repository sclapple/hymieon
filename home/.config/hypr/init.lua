-- Wiki: https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
	-- xdg-portal variables
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- start noctalia
	hl.exec_cmd("noctalia")
	-- start persistent clipboard
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	-- load cursor
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	-- start opentabletdriver
	hl.exec_cmd("otd-daemon")
	-- start jellyfin-mpv-shim
	hl.exec_cmd("jellyfin-mpv-shim")
	-- start steam
	hl.exec_cmd("steam -silent")
	-- start nm-applet
	hl.exec_cmd("nm-applet")
	-- Start alt tab switcher
	hl.exec_cmd("snappy-switcher --daemon")
end)
