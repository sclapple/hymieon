hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("quart", {
	type = "bezier",
	points = { { 0.25, 1 }, { 0.5, 1 } },
})
hl.curve("overshoot", {
	type = "bezier",
	points = { {0.34, 1.2}, {0.64, 1} },
})
hl.curve("bouncy", {
	type = "spring",
	mass = 1,
	stiffness = 55,
	dampening = 16,
})
hl.curve("apple", {
	type = "spring",
	mass = 1,
	stiffness = 130,
	dampening = 24,
})

hl.animation({
	leaf = "global",
	enabled = true,
	speed = 5,
	bezier = "quart",
})
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 5,
	bezier = "quart",
	style = "slide",
})
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4,
	spring = "apple",
	style = "popin 85%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 3,
	spring = "apple",
	style = "popin",
})
hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 4,
	spring = "apple",
	style = "slide",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 5,
	spring = "apple",
	style = "slide",
})
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 4,
	spring = "apple",
	style = "fade",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 4,
	spring = "apple",
	style = "slide",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 5,
	bezier = "quart",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 3,
	bezier = "quart",
})
hl.animation({
	leaf = "fadeSwitch",
	enabled = true,
	speed = 4,
	spring = "apple",
})
hl.animation({
	leaf = "fadeShadow",
	enabled = true,
	speed = 4,
	spring = "apple",
})
hl.animation({
	leaf = "fadeGlow",
	enabled = true,
	speed = 4,
	spring = "apple",
})
hl.animation({
	leaf = "fadeDim",
	enabled = true,
	speed = 7,
	bezier = "quart",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5,
	spring = "apple",
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 5,
	bezier = "quart",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 4,
	bezier = "quart",
	style = "slidefade 30%",
})
