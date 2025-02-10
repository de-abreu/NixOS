local module = {}

function module.apply_to_config(config, color)
	-- Font settings
	config.warn_about_missing_glyphs = false
	config.font_size = 10
	config.line_height = 1.2

	-- Cursor
	config.colors = { cursor_border = color.cursor }

	-- Windows and tabs
	config.window_decorations = "NONE"
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = false
end

return module
