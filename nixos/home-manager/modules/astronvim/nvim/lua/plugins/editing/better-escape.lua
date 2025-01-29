---@type LazySpec
return {
  "max397574/better-escape.nvim",
  opts = {
    default_mappings = false,
    mappings = {
      i = {
        j = { ["ç"] = "<Esc>" },
        ["ç"] = {
          j = "<Esc>",
          ["ç"] = "<Esc>",
        },
      },
      t = {
        ["ç"] = { ["ç"] = "<C-\\><C-n>" },
      },
    },
  },
}
