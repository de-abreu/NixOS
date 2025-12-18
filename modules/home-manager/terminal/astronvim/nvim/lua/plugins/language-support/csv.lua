return {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.programming-language-support.csv-vim" } },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ft = { "csv" },
    opts = {
      parser = { comments = { "#", "//" } },
      view = {
        display_mode = "border",
        header_lnum = 1,
      },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    config = function(_, opts)
      local csvview = require "csvview"
      csvview.setup(opts)
      csvview.enable()
    end,
  },
}
