-- INFO: Set the maximum line length and display a vertical marker to indicate it.

---@type LazySpec
return {
	"xiyaowong/virtcolumn.nvim",
	specs = {
		{
			"AstroNvim/astrocore",
			opts = function(_, opts)
				local opt = opts.options.opt
				-- Set the global maximum line length
				opt.textwidth = 80
				-- Place a vertical line at the column after the length limit
				opt.colorcolumn = "+1"
			end,
		},
		{
			"AstroNvim/astroui",
			opts = {
				highlights = {
					init = {
						ColorColumn = { link = "Comments" },
					},
				},
			},
		},
	},
	event = "VeryLazy",
}
