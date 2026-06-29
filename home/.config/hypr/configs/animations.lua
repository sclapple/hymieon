local configDir = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
local variant = "default"
local f = io.open(configDir .. "/hypr/temp/gamemode-state")
if f then
	f:close()
	variant = "gamemode"
end
package.loaded["configs.animations.default"] = nil
package.loaded["configs.animations.gamemode"] = nil
require("configs.animations." .. variant)
