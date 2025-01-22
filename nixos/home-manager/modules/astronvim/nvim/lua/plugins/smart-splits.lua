-- INFO: More intuitive split pane management that uses a mental model of left/right/up/down instead of wider/narrower/taller/shorter for resizing. Also supports seamless navigation between Neovim and terminal multiplexer split panes.

local plugin = require("smart-splits")

---@type LazySpec
return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	specs = {
		"AstroNvim/astrocore",
		opts = function(_, opts)
			local maps = opts.mappings
			maps.n["<Leader><Leader>"] = { desc = "Swap buffers" }
		end,
	},
	keys = {
		-- NOTE: The key combinations described in the next paragraphs describe, respectively, Alt, Ctrl and <leader> combined with j, k, l, ç. Alt respects the langmap configuration (except for ç, which it takes to be ";"); Ctrl does not; <leader> does (except for ç, which it takes to be ç) Key mapping is weird.

		-- Resizing splits
		{ "<M-h>", plugin.resize_left, desc = "Push vertical border left" },
		{ "<M-j>", plugin.resize_down, desc = "Push horizontal border down" },
		{ "<M-k>", plugin.resize_up, desc = "Push horizontal border up" },
		{ "<M-;>", plugin.resize_right, desc = "Push vertical border right" },

		-- Moving between splits
		{ "<C-j>", plugin.move_cursor_left, desc = "Move cursor to left split" },
		{ "<C-k>", plugin.move_cursor_down, desc = "Move cursor to split below" },
		{ "<C-l>", plugin.move_cursor_up, desc = "Move cursor to split above" },
		{ "<C-;>", plugin.move_cursor_right, desc = "Move cursor to right split" },
		{ "<C-\\>", plugin.move_cursor_previous, desc = "Move cursor to previous split" },

		-- Swap buffers between splits
		{ "<leader><leader>h", plugin.swap_buf_left, desc = "Swap current buffer with the one to the left" },
		{ "<leader><leader>j", plugin.swap_buf_down, desc = "Swap current buffer with the one below" },
		{ "<leader><leader>k", plugin.swap_buf_up, desc = "Swap current buffer with the one above" },
		{ "<leader><leader>ç", plugin.swap_buf_right, desc = "Swap current buffer with the one to the right" },
	},
}
