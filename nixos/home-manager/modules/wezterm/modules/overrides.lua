local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.warn_about_missing_glyphs = false
	table.insert(config.keys, {
		key = "r",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	})
end

return module
