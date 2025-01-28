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
		{ mods = "LEADER", key = "n",  action = act.SpawnTab("CurrentPaneDomain") },
		{ mods = "LEADER", key = "a",  action = act.ActivateTabRelative(-1) },
		{ mods = "LEADER", key = "ç",  action = act.ActivateTabRelative(1) },

		-- Split panes
		{ mods = "LEADER", key = "-",  action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ mods = "LEADER", key = "\\", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		-- Close or maximize panes
		{ mods = "LEADER", key = "q",  action = act.CloseCurrentPane({ confirm = true }) },
		{ mods = "LEADER", key = "z",  action = act.TogglePaneZoomState },

		-- Swap panes
		{ mods = "LEADER", key = "]",  action = act.RotatePanes("Clockwise") },
		{ mods = "LEADER", key = "[",  action = act.RotatePanes("CounterClockwise") },
	}

	-- Switch active tab by its index
	for i = 0, 9 do
		table.insert(mappings, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i),
		})
	end

	if not config.keys then
		config.keys = {}
	end
	for _, mapping in ipairs(mappings) do
		table.insert(config.keys, mapping)
	end
end

return module
