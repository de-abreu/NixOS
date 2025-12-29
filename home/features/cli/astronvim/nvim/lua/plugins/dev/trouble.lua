---@type LazySpec
return {
  "folke/trouble.nvim",
  keys = {
    {
      "<leader>xf",
      "<cmd>Trouble todo toggle filter.buf=0<cr>",
      desc = "Current buffer TODOs",
    },
  },
}
