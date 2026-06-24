require("configs.apps")

configDir = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
scriptsDir = configDir .. "/hypr/scripts"
mainMod = "SUPER"

dofile(configDir .. "/hypr/configs/keybinds/default.lua")

local f = io.open(configDir .. "/hypr/temp/gamemode-state")
if f then f:close(); require("configs.keybinds.gamemode").enter() end
