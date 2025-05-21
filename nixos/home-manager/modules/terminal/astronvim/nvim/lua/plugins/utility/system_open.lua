---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      end,
    },
    window = {
      mappings = {
        O = "system_open",
      },
    },
  },
}
