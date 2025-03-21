local settings = require("settings")
local colors = require("colors")
local icons = require("icons")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal_up = sbar.add("item", {
	position = "right",
	padding_left = 0,
	padding_right = 7,
	width = 0,
	label = {
		color = colors.white,
		font = {
			family = "IosevkaTermSlab Nerd Font",
			size = 11.0,
		},
	},
	y_offset = 5,
})

local cal_down = sbar.add("item", {
	position = "right",
	padding_left = -5,
	padding_right = 8,
	y_offset = -6,
	label = {
		color = colors.white,
		font = {
			family = settings.font.numbers,
			size = 11.0,
		},
	},
})

-- Double border for calendar using a single item bracket
local cal_bracket = sbar.add("bracket", { cal_up.name, cal_down.name }, {
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.transparent,
	},
	update_freq = 1,
})

-- Padding item required because of bracket
local spacing = sbar.add("item", { position = "right", width = 26 })

cal_bracket:subscribe({ "forced", "routine", "system_woke" }, function(env)
	local up_value = os.date("%a %b %d %Y")
	local down_value = os.date("%H:%M:%S %Z")
	cal_up:set({ label = { string = up_value } })
	cal_down:set({ label = { string = down_value } })
end)

-- Click event for opening the calendar
local function click_event(env)
	if settings.calendar and settings.calendar.click_script then
		sbar.exec(settings.calendar.click_script)
	end
end

cal_up:subscribe("mouse.clicked", click_event)
cal_down:subscribe("mouse.clicked", click_event)
