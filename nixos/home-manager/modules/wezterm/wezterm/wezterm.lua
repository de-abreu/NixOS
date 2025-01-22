local wezterm = require("wezterm")
local appearance = require("appearance")
local overrides = require("overrides")
local rendering = require("rendering")
local config = wezterm.config_builder()

appearance.apply_to_config(config)
overrides.apply_to_config(config)
rendering.apply_to_config(config)

return config
