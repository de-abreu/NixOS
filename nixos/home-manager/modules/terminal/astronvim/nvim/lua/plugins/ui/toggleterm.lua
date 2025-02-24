---@LazySpec
return {
	"akinsho/toggleterm.nvim",
	lazy = false,
	opts = function(_, opts)
		opts.open_mapping = "<C-T>"
		opts.insert_mappings = true
		opts.terminal_mappings = true
	end,
}
