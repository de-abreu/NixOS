-- Function to automatically resize windows upon opening or closing neo-tree
local function autoresize(args)
  if args.position == "left" or args.position == "right" then
    vim.cmd "wincmd ="
  end
end

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = autoresize,
      },
      {
        event = "neo_tree_window_after_close",
        handler = autoresize,
      },
    },
  },
}
