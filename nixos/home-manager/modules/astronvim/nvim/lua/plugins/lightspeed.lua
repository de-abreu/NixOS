-- INFO: Allows cursor to "hop" through the screen by typing given character sequences

---@type LazySpec
return {
	"ggandor/lightspeed.nvim",
	-- NOTE: Removing conflicting key mappings from other mappings
	specs = {
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = function(_, opts)
				opts.window.mappings = {
					["s"] = false,
					["S"] = false,
					["-"] = "open_split",
					["\\"] = "open_vsplit",
				}
			end,
		},
		{
			"gbprod/cutlass.nvim",
			opts = function(_, opts)
				opts.exclude = { "ns", "nS" }
			end,
		},
	},
	event = "VimEnter",
	keys = {
		{
			"gs",
			"<Plug>Lightspeed_omni_gs",
			desc = "Move to character in another split",
		},
		{
			"s",
			"<Plug>Lightspeed_x",
			desc = "Move forwards till following character",
			mode = { "n", "o", "x" },
		},
		{
			"S",
			"<Plug>Lightspeed_S",
			desc = "Move backwards till given character",
			mode = { "n", "o", "x" },
		},
	},
}
