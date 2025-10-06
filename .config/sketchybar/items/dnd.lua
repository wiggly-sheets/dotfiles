local colors = require("colors")

local dnd = sbar.add("item", "dnd", {
	label = {
		drawing = true,
		string = "􀆺",
		font = { size = 15 },
		color = colors.white,
	},
	position = "right",
	click_script = 'osascript -e \'tell application "Shortcuts" to run shortcut "Toggle DND"\'',
	padding_right = 12,
	update_freq = 2,
})

local function update_dnd()
	sbar.exec(
		[[defaults read com.apple.controlcenter 'NSStatusItem VisibleCC FocusModes' 2>/dev/null]],
		function(result)
			if result:match("1") then
				dnd:set({ label = { color = 0xffb39df3 } }) -- hardcoded purple because it's different than magenta in color config to match system icon
			else
				dnd:set({ label = { color = colors.grey } })
			end
		end
	)
end

-- Subscribe your DND item to the events
dnd:subscribe({ "routine", "system_woke" }, update_dnd)

update_dnd()
