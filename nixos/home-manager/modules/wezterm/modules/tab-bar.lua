---@diagnostic disable: undefined-field
---@diagnostic disable: undefined-global

local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config, color)
    -- Configure tab bar
    config.hide_tab_bar_if_only_one_tab = false
    config.tab_and_split_indices_are_zero_based = true

    wezterm.on("update-right-status", function(window, _)
        local indicator = " "
        local arrow = ""

        if window:leader_is_active() then
            indicator = " " .. utf8.char(0x1f30a) -- Ocean wave
            arrow = utf8.char(0xe0b2)
        end

        window:set_left_status(wezterm.format({
            { Background = { Color = color.background } },
            { Text = indicator },
            {
                Foreground = {
                    Color = window:active_tab():tab_id() == 0 and color.active_tab or color.inactive_tab,
                },
            },
            { Text = arrow },
        }))
    end)
end

return module
