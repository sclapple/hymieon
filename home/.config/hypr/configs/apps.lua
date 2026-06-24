-- apps.lua - Central app definitions for window rules and keybinds

-- App launch commands (used by keybinds + other modules)
Apps = {
	editor = "nvim",
	editor_fallback = "nano",
	files = "nautilus",
	terminal = "kitty",
	search_engine = "https://www.google.com/search?q={}",
	music = "feishin",
	im = "vesktop",
	password = "keyguard",
	task_manager = "resources",
}

-- App categories for window rules
AppCategories = {
	browser = {
		class_patterns = {
			"[Ff]irefox",
			"org.mozilla.firefox",
			"[Gg]oogle-chrome",
			"chrome-.+-Default",
			"[Cc]hromium",
			"[Mm]icrosoft-edge",
			"[Bb]rave-browser",
			"[Tt]horium-browser",
			"[Cc]achy-browser",
			"zen",
			"zen-alpha",
		},
		tag = "browser",
		workspace = "1",
	},
	terminal = {
		class_patterns = {
			"[Kk]itty",
			"[Aa]lacritty",
		},
		tag = "terminal",
		workspace = "2",
	},
	file_manager = {
		class_patterns = {
			"[Tt]hunar",
			"org.gnome.Nautilus",
			"[Pp]cmanfm-qt",
			"app.drey.Warp",
			"[Nn]emo",
		},
		tag = "file_manager",
		workspace = "3",
	},
	projects = {
		class_patterns = {
			"[Cc]odium",
			"VSCodium",
			"[Cc]ode",
			"VSCode",
			"jetbrains-.+",
			"dev.zed.Zed",
			"antigravity",
			"audacity",
			"osu! skin mixer",
		},
		tag = "projects",
		workspace = "3",
	},
	recording = {
		class_patterns = {
			"obs",
			"com.obsproject.Studio",
		},
		tag = "recording",
		workspace = "4",
	},
	gamestore = {
		class_patterns = {
			"[Ss]team",
			"com.heroicgameslauncher.hgl",
			"HedgeModManager.UI",
			"org.prismlauncher.PrismLauncher",
		},
		tag = "gamestore",
		workspace = "5 silent",
	},
	games = {
		class_patterns = {
			"steam_app_\\d+",
			"gamescope",
			"cs2",
			".*[Mm]inecraft.*",
			"Vintage Story",
			"soh.elf",
			"info.cemu.Cemu",
			"melonDS",
			"UnleashedRecomp",
			"dolphin-emu",
			"Hollow Knight Silksong",
			"osu!",
			"osu![.]exe",
		},
		tag = "games",
		workspace = "6",
	},
	gameutils = {
		class_patterns = {
			"OpenTabletDriver.UX",
			"rewind",
		},
		tag = "gameutils",
		workspace = "6",
	},
	multimedia = {
		class_patterns = {
			"[Mm]pv",
		},
		tag = "multimedia",
	},
	im = {
		class_patterns = {
			"[Dd]iscord",
			"[Ww]ebCord",
			"[Vv]esktop",
			"[Ww]hatsapp-for-linux",
			"org.telegram.desktop",
			"io.github.tdesktop_x64.TDesktop",
		},
		tag = "im",
		workspace = "9",
	},
	music = {
		class_patterns = {
			"[Ss]potify",
			"[Ff]eishin",
			"jellyfin-tui",
		},
		tag = "music",
		workspace = "9 silent",
	},
	settings = {
		class_patterns = {
			"hyprpwcenter",
			"pavucontrol",
			"org.pulseaudio.pavucontrol",
			"com.saivert.pwvucontrol",
			"blueman-manager",
			"nm-connection-editor",
			"nm-applet",
			"qt5ct",
			"qt6ct",
			"file-roller",
			"nwg-look",
			"nwg-displays",
			"btrfs-assistant",
			"hu.irl.cameractrls",
			"io.missioncenter.MissionCenter",
			"CoolerControl",
			"com.github.AppManager",
			"org.gnome.SystemMonitor",
			"org.gnome.baobab",
			"org.gnome.Evince",
			"org.gnome.TextEditor",
			"org.gnome.DiskUtility",
			"dev.noctalia.Noctalia.Settings",
			"net.nokyan.Resources",
			"yazi-configs",
		},
		tag = "settings",
	},
	viewer = {
		class_patterns = {
			"org.gnome.Loupe",
		},
		tag = "viewer",
	},
	password = {
		class_patterns = {
			"[Bb]itwarden",
			"com-artemchep-keyguard-MainKt",
		},
		tag = "password",
	},
}
