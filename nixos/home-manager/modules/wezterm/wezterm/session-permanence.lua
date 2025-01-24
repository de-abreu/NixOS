---@diagnostic disable: undefined-field

-- INFO: Solution adapted from https://github.com/wez/wezterm/issues/2933

local wezterm = require("wezterm")
-- local mux = wezterm.mux
local module = {}

-- -- Decide whether cmd represents a default startup invocation
-- local function is_default_startup(cmd)
-- 	if (not cmd) or (cmd.domain == "DefaultDomain" and not cmd.args) then
-- 		-- we were started with `wezterm` or `wezterm start` with
-- 		-- or without "--cwd something", but otherwise no other arguments
-- 		return true
-- 	end
-- 	-- we were launched some other way
-- 	return false
-- end
--
-- wezterm.on("gui-startup", function(cmd)
-- 	if is_default_startup(cmd) then
-- 		-- for the default startup case, we want to switch to the unix domain instead
-- 		local unix = mux.get_domain("unix")
-- 		mux.set_default_domain(unix)
-- 		-- ensure that it is attached
-- 		unix:attach()
-- 	end
-- end)

function module.apply_to_config(config)
	config.unix_domains = { { name = "unix" } }
	config.default_gui_startup_args = { "connect", "unix" }
end

return module
