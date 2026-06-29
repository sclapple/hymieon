-- Wiki: https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
		snap = {
			enabled = true,
			border_overlap = false,
			respect_gaps = true,
		},
	},

	dwindle = {
		special_scale_factor = 0.8,
		preserve_split = false,
	},

	master = {
		new_status = "master",
		new_on_top = true,
		mfact = 0.50,
	},

	gestures = {
		workspace_swipe_distance = 500,
		workspace_swipe_invert = true,
		workspace_swipe_min_speed_to_force = 30,
		workspace_swipe_cancel_ratio = 0.5,
		workspace_swipe_create_new = true,
		workspace_swipe_forever = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 0,
		mouse_move_enables_dpms = true,
		always_follow_on_dnd = true,
		enable_swallow = false,
		swallow_regex = "^(kitty)$",
		focus_on_activate = false,
		-- initial_workspace_tracking = 2,
		middle_click_paste = false,
		enable_anr_dialog = true,
		anr_missed_pings = 15,
		allow_session_lock_restore = true,
		on_focus_under_fullscreen = 1,
	},

	binds = {
		workspace_back_and_forth = true,
		allow_workspace_cycles = true,
		pass_mouse_when_bound = false,
		allow_pin_fullscreen = true,
	},

	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},

	render = {
		new_render_scheduling = false,
		direct_scanout = 2, -- 2 = auto with game type
		cm_enabled = true,
	},

	cursor = {
		sync_gsettings_theme = true,
		no_hardware_cursors = 2,
		enable_hyprcursor = true,
		warp_on_change_workspace = 1,
		no_warps = true,
		inactive_timeout = 3,
		hide_on_key_press = true,
	},

	ecosystem = {
		no_donation_nag = false,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
