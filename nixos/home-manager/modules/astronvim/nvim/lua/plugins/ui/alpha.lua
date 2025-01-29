return {
	"goolord/alpha-nvim",
	keys = {
		{
			"<leader>,",
			function()
				local is_valid_win = function(win)
					local bufnr = vim.api.nvim_win_get_buf(win)
					return require("astrocore.buffer").is_valid(bufnr) or vim.bo[bufnr].filetype == "alpha"
				end
				local cur_win = vim.api.nvim_get_current_win()
				-- try to find the most suitable window for Alpha
				if not is_valid_win(cur_win) then
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						if win ~= cur_win and is_valid_win(win) then
							vim.fn.win_gotoid(win)
							break
						end
					end
				end
				require("alpha").start(false)
			end,
			desc = "Home Screen",
		},
	},
}
