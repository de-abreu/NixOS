if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: Supported LSPs are listed at https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts_extend = { "servers" },
  opts = {
    servers = {
      "hls",
      "hyprls",
      "prolog_ls",
      "r_language_server",
      "texlab",
      "vhdl_ls",
    },
    config = {
      nixd = { formatting = { command = { "alejandra" } } },
    },
  },
}
