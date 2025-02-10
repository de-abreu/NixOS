local color = require("wezterm").color
local module = {}

function module.apply_to_config(config)
	-- Colorscheme
	local ayu_mirage = color.get_builtin_schemes()["Ayu Mirage"]
	ayu_mirage.background = "#171B24"
	ayu_mirage.cursor_bg = "#F3F4F5"
	ayu_mirage.tab_bar = {
		background = "#1F2430",
		new_tab = {
			bg_color = "#1F2430",
			fg_color = "#D9D7CE",
		},
	}
	ayu_mirage.cursor_border = ayu_mirage.cursor_bg
	config.color_schemes = { ["Ayu Mirage"] = ayu_mirage }
	config.color_scheme = "Ayu Mirage"

	-- Font settings
	config.warn_about_missing_glyphs = false
	config.font_size = 10
	config.line_height = 1.2

	-- Windows and tabs
	config.window_decorations = "NONE"
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = false
end

return module
