-- hyprland.lua
-- DON'T CHANGE UNLESS YOU KNOW WHAT YOU ARE DOING
-- Wiki: https://wiki.hypr.land/Configuring/Start/

-- monitors
require("monitors")

-- workspaces
require("workspaces")

-- startup
require("init")

-- configs
require("configs.animations")
require("configs.decorations")
require("configs.apps")
require("configs.input")
require("configs.environment")
require("configs.gamemode")
require("configs.keybinds")
require("configs.settings")
require("configs.windowrules")

-- For Noctalia Color templates
require("noctalia").apply_theme()
