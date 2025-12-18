--INFO: Wezterm (config) types for Lua Language Server

---@type LazySpec
return {
	"folke/lazydev.nvim",
	ft = "lua",
	dependencies = {
		{ "gonstoll/wezterm-types", lazy = true },
	},
	opts = {
		library = {
			{ path = "wezterm-types", mods = { "wezterm" } },
		},
	},
}
