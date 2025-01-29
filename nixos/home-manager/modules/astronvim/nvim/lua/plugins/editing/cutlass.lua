-- Override the delete operations to not affect the current yank

---@type LazySpec
return {
  "gbprod/cutlass.nvim",
  opts = {
    cut_key = "m",
  },
  keys = {
    { "m", desc = "Cut operation" },
    { "mm", desc = "Cut line" },
  },
}
