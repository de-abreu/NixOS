---@diagnostic disable: undefined-field
-- TODO: Modify hard-coded color values after starting to use stylix

local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.hide_tab_bar_if_only_one_tab = false
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.tab_and_split_indices_are_zero_based = true
end

-- Display an indicator (🌊) whenever the Leader key is active
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = " "

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- Ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end -- Set divider color to be the same as that of the first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

return module
