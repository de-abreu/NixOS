-- INFO: Add symbols surrounding a selection

---@type LazySpec
return {
	"kylechui/nvim-surround",
	specs = {
		"AstroNvim/astrocore",
		opts = function(_, opts)
			local map = opts.mappings.n
			local word_under_cursor = vim.fn.expand("<cword>")
			map["zc"] = {
				function()
					vim.cmd("spellgood " .. word_under_cursor)
				end,
				desc = "Add word under cursor to dictionary",
			}
			map["zr"] = {
				function()
					vim.cmd("spellwrong " .. word_under_cursor)
				end,
				desc = "Remove word under cursor from dictionary",
			}
		end,
	},
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	opts = {
		keymaps = {
			normal = "z",
			normal_cur = "zz",
			normal_line = "Z",
			normal_cur_line = "ZZ",
			visual = "z",
			visual_line = "Z",
			delete = "dz",
			change = "cz",
			change_line = "cZ",
		},
	},
}
