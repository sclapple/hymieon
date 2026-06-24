-- Wiki: https://wiki.hypr.land/Configuring/Basics/Keybinds/

local configDir = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
local decorations_dir = configDir .. "/hypr/configs/decorations"
local animations_dir = configDir .. "/hypr/configs/animations"
local noctalia_settings = configDir .. "/noctalia/wallpaper.toml"
local popups_settings = configDir .. "/noctalia/osd.toml"
local state_file = configDir .. "/hypr/temp/gamemode-state"
local gamemode_keys = require("configs.keybinds.gamemode")

-- gamemode toggle
local gamemode_on = false

toggle_gamemode = function()
	gamemode_on = not gamemode_on

	if gamemode_on then
		dofile(decorations_dir .. "/gamemode.lua")
		dofile(animations_dir .. "/gamemode.lua")
		local f = io.open(state_file, "w"); if f then f:close() end
		hl.exec_cmd("sed -i '/^\\[wallpaper\\]$/,/^\\[/ s/enabled = true/enabled = false/' " .. noctalia_settings)
		hl.exec_cmd("noctalia msg notification-dnd-toggle")
		hl.exec_cmd("sed -i 's/^lock_keys = .*/lock_keys = false/' " .. popups_settings)
		gamemode_keys.enter()
	else
		os.remove(state_file)
		dofile(decorations_dir .. "/default.lua")
		dofile(animations_dir .. "/default.lua")
		hl.exec_cmd("sed -i '/^\\[wallpaper\\]$/,/^\\[/ s/enabled = false/enabled = true/' " .. noctalia_settings)
		hl.exec_cmd("noctalia msg notification-dnd-toggle")
		hl.exec_cmd("sed -i 's/^lock_keys = .*/lock_keys = true/' " .. popups_settings)
		gamemode_keys.exit()
	end
end

