---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local unique = require("astrocore").list_insert_unique
      opts.servers = unique(opts.sources, { "texlab" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "kdheepak/cmp-latex-symbols" },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "latex_symbols", priority = 700 },
      }
    end,
  },
  ---@type LazyPluginSpec
  {
    "lervag/vimtex",
    lazy = true,
    ft = "tex",
  },
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrocore",
    opts = { options = { g = {
      maplocalleader = ",",
      vimtex_view_method = "zathura",
    } } },
  },
  ---@type LazyPluginSpec
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    ft = "tex",
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup()
      require("luasnip").config.setup { enable_autosnippets = true }
    end,
  },
  ---@type LazyPluginSpec
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        tex = { "vale" },
        markdown = { "vale" },
      },
    },
  },
}
