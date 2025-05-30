local colors = require("colors")
local app_icons = require("helpers.app_icons")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	-- Initialize the icon area (hidden until an app is active)
	icon = {
		drawing = false,
		font = "sketchybar-app-font:Regular:12.0", -- Ensure this is your icon font
		string = "",
		padding_right = 0,
		padding_left = 4,
		color = colors.white,
	},

	click_script = [[
osascript -e 'tell application "System Events" to set frontApp to name of first application process whose frontmost is true' \
-e 'tell application "System Events" to tell process frontApp to click menu item ("About " & frontApp) of menu 1 of menu bar item frontApp of menu bar 1'
]],
})

front_app:subscribe("front_app_switched", function(env)
	-- env.INFO is assumed to be the app name (e.g., "Safari")
	local app = env.INFO
	-- Look up the icon for the app; fall back to "Default" if none is found.
	local icon = app_icons[app] or app_icons["Default"]

	front_app:set({
		-- Enable icon drawing and set the proper icon font, string, and color
		icon = {
			drawing = true,
			string = icon,
			font = "sketchybar-app-font:Regular:12.0", -- Must be an icon-supporting font
			padding_right = -12,
			color = colors.white,
		},
	})
end)
