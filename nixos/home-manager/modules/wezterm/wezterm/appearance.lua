local module = {}

function module.apply_to_config(config)
	config.color_scheme = "One Dark (Gogh)" -- TODO: Use stylix to rice the whole desktop into a single theme

	-- Font settings
	config.font_size = 10
	config.line_height = 1.2

	-- Appearence
	config.window_decorations = "NONE"
	config.hide_tab_bar_if_only_one_tab = true
end

return module
