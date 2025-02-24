-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts_extend = { "server" },
  opts = {
    server = {
      "hls",
      "hyprls",
      "prolog_ls",
      "r_language_server",
      "vhdl_ls",
    },
  },
}
