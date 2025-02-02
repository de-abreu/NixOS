-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
	"AstroNvim/astrolsp",
	---@type AstroLSPOpts
	opts = function(plugin, opts)
		opts.servers = opts.servers or {}
		vim.list_extend(opts.servers, {
			"hls",
			"hyprls",
			"prolog_ls",
			"r_language_server",
			"vhdl_ls",
		})
	end,
}
