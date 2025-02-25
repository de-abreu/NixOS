-- INFO: Customize None-ls sources
-- Check supported formatters and linters
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    -- Only inserts new sources, does not replace existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.alejandra,
    })
  end,
}
