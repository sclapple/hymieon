hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("quart",      { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 }    } })
hl.curve("expo",       { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 }    } })
hl.curve("md3_accel",  { type = "bezier", points = { { 0.3, 0 },  { 0.8, 0.15 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 },  { 0, 1 }      } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })

hl.animation({ leaf = "windows",          enabled = true, speed = 2,   bezier = "quart",      style = "popin 60%" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 2,   bezier = "quart",      style = "popin 60%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 2,   bezier = "md3_accel",  style = "popin 60%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3,   bezier = "quart" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 2,   bezier = "expo",       style = "slide" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 2,   bezier = "expo" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3.5, bezier = "expo",       style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "quart",      style = "slidevert" })
