-- Wiki: https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- stylua: ignore start
require("configs.apps")

-- ── Tag rules from AppCategories ──────────────────────────────────────
for _, cat in pairs(AppCategories) do
  if #cat.class_patterns > 0 then
    local pattern = "^(" .. table.concat(cat.class_patterns, "|") .. ")$"
    hl.window_rule({ match = { class = pattern }, tag = "+" .. cat.tag })
  end
end

-- ── Workspace assignments from AppCategories ──────────────────────────
for _, cat in pairs(AppCategories) do
  if cat.workspace then
    hl.window_rule({ match = { tag = cat.tag }, workspace = cat.workspace })
  end
end

-- ── Title / xdg-tag based tag rules ──────────────────────────────────
hl.window_rule({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })
hl.window_rule({ match = { xdg_tag = "^(proton-game)$" }, tag = "+games" })

-- ── Idle inhibit ─────────────────────────────────────────────────────
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { fullscreen = 2 }, idle_inhibit = "fullscreen" })

-- ── Floating dialogs ─────────────────────────────────────────────────
hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
hl.window_rule({
  match = { title = "^(Save As)$" },
  float = true,
  size = "(monitor_w*0.7) (monitor_h*0.6)",
  center = true,
})
hl.window_rule({
  match = { title = "^(Open Files)" },
  float = true,
  size = "(monitor_w*0.7) (monitor_h*0.6)",
})
hl.window_rule({
  match = { title = "^(Add Folder to Workspace)$" },
  float = true,
  size = "(monitor_w*0.7) (monitor_h*0.6)",
  center = true,
})
hl.window_rule({
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
  opaque = true,
  pin = true,
  keep_aspect_ratio = true,
  size = "(monitor_w*0.3) (monitor_h*0.3)",
  no_blur = true,
  move = "(window_w*2.22) (window_h*0.115)",
})
hl.window_rule({ match = { title = "^(Sign in to Steam)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(yad)$" }, float = true, center = true, size = "(monitor_w*0.2) (monitor_h*0.2)" })
hl.window_rule({ match = { class = "^(hyprland-donate-screen)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(SDDM Background)$" }, float = true, center = true, size = "(monitor_w*0.16) (monitor_h*0.12)" })

-- File manager sub-windows
hl.window_rule({ match = { class = "[Tt]hunar", title = "negative:(.*[Tt]hunar.*)" }, float = true, center = true })
hl.window_rule({
  match = { class = "[Nn]emo", title = "(.*[Pp]roperties.*|.*[Pp]rogress.*|.*[Cc]ompress.*|.*[Ee]xtract.*|.*[Cc]opy.*|.*[Mm]ove.*|.*[Dd]elete.*|.*[Rr]ename.*)" },
  float = true,
  center = true,
})

-- ── Tag property rules ───────────────────────────────────────────────
hl.window_rule({ match = { tag = "screenrecording" }, no_blur = true, opaque = true })
hl.window_rule({
  match = { tag = "settings" },
  size = "(monitor_w*0.4) (monitor_h*0.6)",
  float = true,
  center = true,
  pin = true,
})
hl.window_rule({
  match = { tag = "game" },
  no_blur = true,
  fullscreen = 1,
  opaque = true,
  immediate = 1,
  content = "game",
})
hl.window_rule({
  match = { tag = "multimedia" },
  no_blur = true,
  opaque = true,
  float = true,
  center = true,
  keep_aspect_ratio = true,
  content = "video",
})
hl.window_rule({ match = { tag = "password" }, float = true, center = true, size = "(monitor_w*0.4) (monitor_h*0.5)" })
hl.window_rule({ match = { tag = "viewer" }, float = true, center = true })
hl.window_rule({ match = { tag = "gameutils" }, float = true, center = true, size = "(monitor_w*0.4) (monitor_h*0.6)" })

-- ── Portal share picker ────────────────────────────────────────────
hl.window_rule({ match = { class = "^(hyprland-share-picker)$" }, workspace = "unset" })

-- ── Per-app exceptions ───────────────────────────────────────────────
hl.window_rule({
  match = { class = "^(osu!)$" },
  no_blur = true,
  opaque = true,
  immediate = true,
  fullscreen = 1,
  content = "game",
})
hl.window_rule({
  match = { class = "^(osu![.]exe)$" },
  workspace = "6 silent",
  no_blur = true,
  opaque = true,
  immediate = true,
  fullscreen = 1,
  content = "game",
})
hl.window_rule({ match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" }, float = true })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)", title = "negative:(Heroic Games Launcher)" }, float = true })
hl.window_rule({ match = { class = "^(OpenTabletDriver.UX)$" }, float = true, pin = true, size = "(monitor_w*0.4) (monitor_h*0.6)" })

hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" }, center = true })

-- persistent workspace
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-3", persistent = true })
end
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1", persistent = true })

-- ── noctalia background layer ────────────────────────────────────────

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|osd)$",
  },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

-- xwayland-video-bridge-fixes
hl.window_rule({
  match = { class = "^(xwaylandvideobridge)$" },
  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = "1 1",
  opacity = 0.0,
})
-- stylua: ignore end
