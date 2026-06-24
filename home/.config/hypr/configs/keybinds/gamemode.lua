local mainMod = "SUPER"
local configDir = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
local scriptsDir = configDir .. "/hypr/scripts"

local function hide_desktop_keys()
	hl.unbind(mainMod .. " + P")
	hl.unbind(mainMod .. " + S")
	hl.unbind(mainMod .. " + T")
	hl.unbind(mainMod .. " + D")
	hl.unbind(mainMod .. " + A")
	hl.unbind(mainMod .. " + ALT + S")
	hl.unbind(mainMod .. " + ALT + F")
	hl.unbind(mainMod .. " + SHIFT + O")
	hl.unbind(mainMod .. " + ALT + L")
end

local function restore_desktop_keys()
	hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(Apps.password), { desc = "Open default password manager" })
	hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(Apps.music), { desc = "Open music player" })
	hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(Apps.task_manager), { desc = "Open system monitor" })
	hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(Apps.im), { desc = "Open Discord client" })
	hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty --class viu -- viu-media"), { desc = "Open anime viewer" })
	hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("lutris"), { desc = "Open game launcher" })
	hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ internal = "0", client = "2", action = "toggle" }), { desc = "Toggle 'fake' fullscreen" })
	hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("noctalia msg settings-toggle"), { desc = "Toggle Noctalia settings" })
	hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), { desc = "Power menu" })
end

local M = {}

function M.enter()
	hide_desktop_keys()

	hl.unbind(mainMod .. " + F")
	hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }), { desc = "Fake fullscreen" })

	hl.unbind(mainMod .. " + SHIFT + F")
	hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { desc = "True fullscreen" })

	hl.unbind(mainMod .. " + SHIFT + S")
	hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"), { desc = "Screenshot selected area" })

	hl.unbind(mainMod .. " + O")
	hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("opentabletdriver-gui"), { desc = "Open tablet driver GUI" })

	hl.unbind(mainMod .. " + ALT + P")
	hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), { desc = "Power menu" })

	hl.bind(mainMod .. " + CTRL + ALT + P", hl.dsp.exec_cmd(scriptsDir .. "/monitorOnOff.sh"), { desc = "Toggle monitor on/off" })
end

function M.exit()
	hl.unbind(mainMod .. " + CTRL + ALT + P")

	hl.unbind(mainMod .. " + F")
	hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = "1", client = "0", action = "toggle" }), { desc = "Toggle Maximized window" })

	hl.unbind(mainMod .. " + SHIFT + F")
	hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = "2", client = "2", action = "toggle" }), { desc = "Toggle fullscreen window" })

	hl.unbind(mainMod .. " + SHIFT + S")
	hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"), { desc = "Screenshot" })

	hl.unbind(mainMod .. " + O")
	hl.bind(mainMod .. " + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { desc = "Toggle active window opacity" })

	hl.unbind(mainMod .. " + ALT + P")
	hl.bind(mainMod .. " + ALT + P", hl.dsp.window.pin({ value = "toggle" }), { desc = "Toggle active window pinning" })

	restore_desktop_keys()
end

return M
