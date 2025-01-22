local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.keys = {
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	}
end

return module
