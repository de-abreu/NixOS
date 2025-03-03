-- Completion suggestions

return {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "jmbuhr/cmp-pandoc-references",
    "jmbuhr/otter.nvim",
    "onsails/lspkind-nvim",
    "rafamadriz/friendly-snippets",
    "ray-x/cmp-treesitter",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "emoji", priority = 700 },

      -- INFO:  Sources added with the Quarto installation. Taken from: https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/main/lua/plugins/completion.lua
      { name = "otter", priority = 700 }, -- for code chunks in quarto
      { name = "nvim_lsp_signature_help", priority = 700 },
      { name = "pandoc_references", priority = 700 },
      { name = "spell", priority = 700, keyword_length = 5, max_item_count = 3 },
      { name = "treesitter", priority = 700, keyword_length = 5, max_item_count = 3 },
      { name = "calc", priority = 700 },
    }
  end,
}
