local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local module = {}

function module.apply_to_config(config)
	smart_splits.apply_to_config(config, {
		-- directional keys to use in order of: left, down, up, right
		direction_keys = { "j", "k", "l", "ç" },
		-- modifier keys to combine with direction_keys
		modifiers = {
			move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+j to move left
			resize = "META", -- modifier to use for pane resize, e.g. META+j to resize to the left
		},
		-- log level to use: info, warn, error
		log_level = "info",
	})
end

return module
