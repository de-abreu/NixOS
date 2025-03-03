local unique = require("astrocore").list_insert_unique

---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local servers = opts.servers
      servers = unique(servers, { "vhdl_ls" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local ensure_installed = opts.ensure_installed
      ensure_installed = unique(ensure_installed, { "vhdl" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = unique(opts.sources, {
        null_ls.builtins.formatting.emacs_vhdl_mode,
      })
    end,
  },
  ---@type LazyPluginSpec
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = { vhdl = { "vsg" } } },
  },
}
