---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  optional = true,
  opts = function(_, opts)
    local actions = require "telescope.actions"
    opts.defaults = {
      mappings = {
        i = {
          ["<C-N>"] = actions.cycle_history_next,
          ["<C-P>"] = actions.cycle_history_prev,
          ["<C-Q>"] = actions.close,
        },
        n = { q = actions.close },
      },
    }
  end,
  keys = {
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search" },
  },
}
