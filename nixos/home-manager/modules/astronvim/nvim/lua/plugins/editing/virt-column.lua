-- INFO: Set a maximum line length to hardwrap commentaries, and place a
-- vertical marker to indicate it.

---@type LazySpec
return {
	"lukas-reineke/virt-column.nvim",
	specs = {
		{
			"AstroNvim/astrocore",
			-- Automatically break commentaries at the 80 characters mark.
			opts = {
				autocmds = {
					auto_textwidth = {
						{
							event = "BufWinEnter",
							desc = "Set virtcolumn solelly to buffers",
							callback = function(args)
								local buffer = require "astrocore.buffer"
								if buffer.is_valid(args.buf) then
									vim.opt_local.textwidth = 80
								end
							end,
						},
					},
				},
			},
		},
	},
	event = "VeryLazy",
	opts = {
		char = "🭰",
		highlight = "Comment",
		virtcolumn = "+1",
	},
}
