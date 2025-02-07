---@diagnostic disable: undefined-field
local module = {}

function module.apply_to_config(config)
	config.unix_domains = { { name = "unix" } }          -- Setup a multiplexer via a unix socket, if it wasn't already
	config.default_gui_startup_args = { "connect", "unix" } -- Connect to the unix domain on startup
end

return module
