-- Wiki: https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
for i = 1, 8 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-3", default = i == 1 })
end
for i = 9, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", default = i == 9 })
end
