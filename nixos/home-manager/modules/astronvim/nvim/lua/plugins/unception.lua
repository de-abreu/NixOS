-- INFO: Terminal buffers will no longer enter a state of "inception" in which an instance of Neovim is open within an instance of Neovim. Instead, the desired files and directories will be opened by the "host" Neovim session.

---@type LazySpec
return {
	"samjwill/nvim-unception",
	lazy = false,
	priority = 1001,
	dependencies = {
		"AstroNvim/astrocore",
		opts = function(_, opts)
			local g = opts.options.g
			g["unception_block_while_host_edits"] = true
		end,
	},
}
