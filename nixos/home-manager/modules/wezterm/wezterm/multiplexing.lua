---@diagnostic disable: undefined-field

local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local act = wezterm.action
local module = {}

-- INFO: Configuring integration with neovim
function module.apply_to_config(config)
	smart_splits.apply_to_config(config, {
		-- directional keys to use in order of: left, down, up, right
		-- NOTE: When combined with modifier keys, "ç" is read as ";"
		direction_keys = { "j", "k", "l", ";" },
		modifiers = {
			move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+j to move left
			resize = "META", -- modifier to use for pane resize, e.g. META+j to resize to the left
		},
		-- log level to use: info, warn, error
		log_level = "info",
	})

	-- Assigning keybindings compatible with those of Astronvim
	local mappings = {

		-- Tabs
		{ mods = "LEADER", key = "n", action = act.SpawnTab("CurrentPaneDomain") },
		{ mods = "CTRL|SHIFT", key = "k", action = act.ActivateTabRelative(-1) },
		{ mods = "CTRL|SHIFT", key = "l", action = act.ActivateTabRelative(1) },

		-- Panes
		{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ mods = "LEADER", key = "q", action = act.CloseCurrentPane({ confirm = true }) },
		{ mods = "LEADER", key = "]", action = act.RotatePanes("Clockwise") },
		{ mods = "LEADER", key = "[", action = act.RotatePanes("CounterClockwise") },
		{ mods = "LEADER", key = "z", action = act.TogglePaneZoomState },
	}

	if not config.keys then
		config.keys = {}
	end
	for _, mapping in ipairs(mappings) do
		table.insert(config.keys, mapping)
	end
end

return module
