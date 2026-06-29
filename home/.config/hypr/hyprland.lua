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
package.loaded["configs.animations"] = nil
require("configs.animations")
package.loaded["configs.decorations"] = nil
require("configs.decorations")
require("configs.apps")
require("configs.input")
require("configs.environment")
require("configs.gamemode")
package.loaded["configs.keybinds"] = nil
package.loaded["configs.keybinds.default"] = nil
package.loaded["configs.keybinds.gamemode"] = nil
require("configs.keybinds")
require("configs.settings")
require("configs.windowrules")

-- For Noctalia Color templates
require("noctalia").apply_theme()

-- HyprMod managed settings
-- require("hyprland-gui")
