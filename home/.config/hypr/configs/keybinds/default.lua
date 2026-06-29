-- stylua: ignore start

-- applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(Apps.terminal), { desc = "Open default terminal" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("xdg-open 'https://'"), { desc = "Open default browser" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(Apps.files), { desc = "Open default file manager" })
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(Apps.password), { desc = "Open default password manager" })
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(Apps.music), { desc = "Open music player" })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(Apps.task_manager), { desc = "Open system monitor" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(Apps.im), { desc = "Open Discord client" })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("lutris"), { desc = "Open game launcher" })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("kitty --class yazi-configs -- yazi .config/hypr/"), { desc = "Browse config files" })

-- gamemode
hl.bind(mainMod .. " + SHIFT + G", toggle_gamemode, { desc = "Toggle gamemode" })

-- window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { desc = "Close active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill(), { desc = "Kill active window" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = "1", client = "0", action = "toggle" }), { desc = "Toggle Maximized window" })
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ internal = "0", client = "2", action = "toggle" }), { desc = "Toggle 'fake' fullscreen" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = "2", client = "2", action = "toggle" }), { desc = "Toggle fullscreen window" })
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }), { desc = "Toggle floating for active window" })
hl.bind(mainMod .. " + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { desc = "Toggle active window opacity" })
hl.bind(mainMod .. " + ALT + P", hl.dsp.window.pin({ value = "toggle" }), { desc = "Toggle active window pinning" })

-- noctalia
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"), { desc = "Noctalia app launcher" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("noctalia msg wallpaper-random"), { desc = "Random wallpaper" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"), { desc = "Wallpaper selector" })
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), { desc = "Power menu" })
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("noctalia msg bar-toggle"), { desc = "Toggle Bar" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("noctalia msg screenshot-region"), { desc = "Screenshot" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("kitty --class yazi-configs -- yazi .config/noctalia/"), { desc = "Browse noctalia configs" })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("noctalia msg settings-toggle"), { desc = "Toggle Noctalia settings" })
hl.bind(mainMod .. " + ALT + K", hl.dsp.exec_cmd('noctalia msg panel-toggle launcher "/binds"'), { desc = "Keybind browser" })

-- workspaces
hl.bind("ALT + SHIFT + TAB", hl.dsp.focus({ workspace = "previous" }), { desc = "Swap to last workspace" })
hl.bind("ALT + TAB", hl.dsp.exec_cmd("snappy-switcher next --mod alt"), { desc = "Cycle through windows on the same workspace" })

for i = 1, 10 do
  local key = "code:" .. (9 + i)
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }),
          { desc = "workspace " .. i })
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
          { desc = "move to workspace " .. i })
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, silent = true }),
          { desc = "move silently to workspace " .. i })
end

-- focus and movement
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize window" })

local dirs = {
  { key = "left",  dir = "left",  dx = -50, dy = 0  },
  { key = "right", dir = "right", dx = 50,  dy = 0  },
  { key = "up",    dir = "up",    dx = 0,   dy = -50 },
  { key = "down",  dir = "down",  dx = 0,   dy = 50  },
  { key = "h",     dir = "left",  dx = -50, dy = 0  },
  { key = "l",     dir = "right", dx = 50,  dy = 0  },
  { key = "j",     dir = "down",  dx = 0,   dy = 50  },
  { key = "k",     dir = "up",    dx = 0,   dy = -50 },
}

for _, d in ipairs(dirs) do
  hl.bind(mainMod .. " + " .. d.key, hl.dsp.focus({ direction = d.dir }),
          { desc = "focus " .. d.dir })
  hl.bind(mainMod .. " + SHIFT + " .. d.key, hl.dsp.window.move({ direction = d.dir }),
          { desc = "move window " .. d.dir })
  hl.bind(mainMod .. " + CTRL + " .. d.key,
          hl.dsp.window.resize({ x = d.dx, y = d.dy, relative = true }),
          { repeating = true, desc = ("resize %s (%+d)"):format(d.dir, d.dx ~= 0 and d.dx or d.dy) })
end

-- stylua: ignore end
