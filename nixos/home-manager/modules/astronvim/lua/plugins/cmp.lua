-- Completion suggestions

return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the mapping part of the table
    opts.mapping = {
      ["<C-k>"] = cmp.mapping.select_next_item(),
      ["<C-l>"] = cmp.mapping.select_prev_item(),
    }
  end,
}
