-- Wiki: https://wiki.hypr.land/Configuring/Basics/Input/
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		repeat_rate = 50,
		repeat_delay = 300,
		sensitivity = 0,
		accel_profile = "flat",
		left_handed = false,
		follow_mouse = 2,
		float_switch_override_focus = 1,
		numlock_by_default = true,
		focus_on_close = 0,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = false,
			middle_button_emulation = true,
			tap_to_click = true,
			drag_lock = false,
		},
		touchdevice = {
			enabled = true,
		},
		tablet = {
			output = "DP-3",
		},
	},
})
