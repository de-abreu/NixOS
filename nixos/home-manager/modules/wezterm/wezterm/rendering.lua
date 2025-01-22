local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.front_end = "WebGpu" -- INFO: Fixes font rendering issues, see https://github.com/NixOS/nixpkgs/issues/334650
	config.max_fps = 120
end

return module
