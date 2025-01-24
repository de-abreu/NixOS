local config = require("wezterm").config_builder() -- [[@as Wezterm]]

-- Set leader key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.debug_key_events = true

require("multiplexing").apply_to_config(config)
require("appearance").apply_to_config(config)
require("overrides").apply_to_config(config)
require("rendering").apply_to_config(config)
require("scrollback-nvim").apply_to_config(config)
require("tab-bar").apply_to_config(config)

return config
