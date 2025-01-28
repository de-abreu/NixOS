-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
	"AstroNvim/astroui",
	---@type AstroUIOpts
	opts = {
		-- change colorscheme
		colorscheme = "astrodark",
		-- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
		highlights = {
			init = { -- this table overrides highlights in all themes
				-- Normal = { bg = "#000000" },
			},
			astrodark = { -- a table of overrides/changes when applying the astrotheme theme
				Normal = { bg = "#171B24" },
			},
		},
	},
}
