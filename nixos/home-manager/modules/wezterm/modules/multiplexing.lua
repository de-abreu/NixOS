---@diagnostic disable: undefined-field
local module = {}

function module.apply_to_config(config)
    -- Attempt to query current workspace
    local handle = io.popen("hyprctl activeworkspace")
    local workspace = "unix"

    if handle then
        local output = handle:read("*l")
        workspace = output:match("workspace ID %d+")
        handle:close()
    end

    -- Create and/or attach to a multiplexer assigned to the current workspace on startup
    config.unix_domains = { { name = workspace } }
    config.default_gui_startup_args = { "connect", workspace }
end

return module
