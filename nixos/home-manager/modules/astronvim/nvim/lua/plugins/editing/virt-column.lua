-- INFO: Set a maximum line length to hardwrap commentaries, and place a
-- vertical marker to indicate it.

---@type LazySpec
return {
  "lukas-reineke/virt-column.nvim",
  event = "VeryLazy",
  opts = {
    char = "🭰",
    highlight = "Comment",
    virtcolumn = "80",
  },
}
