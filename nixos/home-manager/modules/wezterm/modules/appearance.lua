local module = {}

function module.apply_to_config(config)
	-- Font settings
	config.font_size = 10
	config.line_height = 1.2

	-- Cursor
	config.colors = { cursor_border = "white" }

	-- Windows and tabs
	config.window_decorations = "NONE"
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
end

return module
