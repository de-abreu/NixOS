local resize = function(args)
	if args.position == "left" or args.position == "right" then
		vim.cmd "wincmd ="
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"s1n7ax/nvim-window-picker",
			version = "2.*",
			opts = {
				filter_rules = {
					include_current_win = false,
					autoselect_one = true,
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify", "nofile" },
						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix", "nofile" },
					},
				},
				show_prompt = false,
			},
		},
	},
	opts = {
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			"document_symbols",
		},
		event_handlers = {
			{
				event = "neo_tree_window_after_open",
				handler = resize,
			},
			{
				event = "neo_tree_window_after_close",
				handler = resize,
			},
		},
		window = {
			mappings = {
				H = "prev_source",
				["<S-Ç>"] = "next_source",
				["ç"] = "open_with_window_picker",
				h = "close_node",
				u = "toggle_hidden",
			},
		},
		buffers = {
			follow_current_file = { enabled = true },
		},
		filesystem = {
			filtered_items = {
				hide_by_name = {
					"node_modules",
				},
				never_show = {
					".DS_Store",
					"thumbs.db",
				},
			},
		},
	},
}
