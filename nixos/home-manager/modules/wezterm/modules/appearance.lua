local module = {}

function module.apply_to_config(config)
	-- config.color_scheme = "One Dark (Gogh)" -- TODO: Use stylix to rice the whole desktop into a single theme

	-- Font settings
	config.font_size = 10
	config.line_height = 1.2

	-- Appearence
	config.window_decorations = "NONE"
end

return module
