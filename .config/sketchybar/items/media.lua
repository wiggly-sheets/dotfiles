local icons = require("icons")
local colors = require("colors")
local whitelist = { ["Music"] = true }
local popup_shown = false

--------------------------------------------------
-- MAIN WIDGET
--------------------------------------------------
local media_cover = sbar.add("item", {
	name = "media_cover",
	position = "right",
	border_color = colors.red,
	border_width = 1,
	background = {
		image = { string = "", scale = 0 },
		drawing = true,
		color = colors.transparent,
		border = colors.red,
		border_width = 1,
	},
	label = { drawing = false },
	icon = { drawing = false, string = icons.music },
	drawing = true,
	updates = true,
	popup = {
		align = "center",
		horizontal = false,
		width = "dynamic",
		drawing = false,
	},
})

--------------------------------------------------
-- MEDIA CONTROLS
--------------------------------------------------

-- Next Button
local next_button = sbar.add("item", {
	name = "next_button",
	position = "right",
	icon = {
		string = icons.media.forward,
		drawing = true,
		font = { size = 14.0 },
	},
	label = { drawing = false },
	click_script = "nowplaying-cli next",
	width = 20,
	align = "right",
	padding_left = 5,
	padding_right = 5,
})

-- Play/Pause Button
local play_button = sbar.add("item", {
	name = "play_button",
	position = "right",
	icon = {
		string = icons.media.play,
		drawing = true,
		font = { size = 14.0 },
	},
	label = { drawing = false },
	click_script = "nowplaying-cli togglePlayPause",
	width = 20,
	align = "center",
	padding_left = 9,
	padding_right = 11,
})

local prev_button = sbar.add("item", {
	name = "prev_button",
	position = "right",
	icon = {
		string = icons.media.back,
		drawing = true,
		font = { size = 14.0 },
		align = "left",
	},
	label = { drawing = false },
	click_script = "nowplaying-cli previous",
	width = 20,
	align = "left",
	padding_left = 5,
	padding_right = 7,
})

--------------------------------------------------
-- POPUP CONTENT
--------------------------------------------------
-- Artist
local popup_artist = sbar.add("item", {
	name = "popup_artist",
	position = "popup." .. media_cover.name,
	label = {
		string = "Artist:",
		font = "IosevkaTermSlab Nerd Font",
		drawing = true,
		max_chars = 30,
	},
	alignment = "center",
})

-- Album
local popup_album = sbar.add("item", {
	name = "popup_album",
	position = "popup." .. media_cover.name,
	label = {
		string = "Album:",
		font = "IosevkaTermSlab Nerd Font",
		drawing = true,
		max_chars = 30,
	},
	alignment = "center",
})

-- Song
local popup_song = sbar.add("item", {
	name = "popup_song",
	position = "popup." .. media_cover.name,
	label = {
		string = "Song:",
		font = "IosevkaTermSlab Nerd Font",
		drawing = true,
		max_chars = 40,
	},
	alignment = "center",
})

--------------------------------------------------
-- UPDATE FUNCTION
--------------------------------------------------
local function update_widget(env)
	if env and env.INFO and whitelist[env.INFO.app] then
		local state = env.INFO.state
		local artist = env.INFO.artist or "Unknown Artist"
		local album = env.INFO.album or "Unknown Album"
		local title = env.INFO.title or "Unknown Song"

		popup_artist:set({ label = { string = "Artist: " .. artist } })
		popup_album:set({ label = { string = "Album: " .. album } })
		popup_song:set({ label = { string = "Song: " .. title } })

		media_cover:set({
			background = {
				image = (state == "playing" or state == "paused") and { string = "media.artwork", scale = 1.0 }
					or { string = "", scale = 0 },
				color = colors.transparent,
			},
			icon = { drawing = not (state == "playing" or state == "paused") },
		})

		-- Update play/pause button icon
		play_button:set({
			icon = {
				string = state == "playing" and icons.media.pause or icons.media.play,
				drawing = true,
			},
		})
	else
		media_cover:set({
			background = { image = { string = "", scale = 0 }, color = colors.transparent },
			icon = { drawing = true },
		})
	end
end

media_cover:subscribe("media_change", update_widget)

-- Function to toggle visibility based on music status
local function update_media_controls()
	sbar.exec("nowplaying-cli status", function(status)
		local is_playing = status:match("playing")

		-- Show or hide items based on playback state
		prev_button:set({ drawing = true })
		play_button:set({ drawing = true })
		next_button:set({ drawing = true })
		media_cover:set({ drawing = true })
	end)
end

-- Subscribe to music updates
sbar.add("event", "media_update", { "nowplaying-cli track_change", "nowplaying-cli playback_state" })
sbar.subscribe("media_update", update_media_controls)

-- Run once at startup to check if music is already playing
update_media_controls()

--------------------------------------------------
-- POPUP TOGGLE LOGIC
--------------------------------------------------
media_cover:subscribe("mouse.clicked", function(env)
	popup_shown = not popup_shown
	media_cover:set({ popup = { drawing = popup_shown } })
end)

media_cover:subscribe("mouse.exited.global", function(env)
	popup_shown = false
	media_cover:set({ popup = { drawing = false } })
end)
