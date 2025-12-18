---@type LazySpec
return {
  "max397574/better-escape.nvim",
  optional = true,
  opts = {
    default_mappings = false,
    mappings = {
      i = {
        j = {
          j = false,
          k = false,
          ["ç"] = "<Esc>",
        },
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
