-- INFO: File-tree navigator

return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      opts = {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "nofile" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix", "nofile" },
          },
        },
        show_prompt = false,
      },
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    buffers = {
      follow_current_file = { enabled = true },
    },
    filesystem = {
      filtered_items = {
        hide_by_name = {
          "node_modules",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
}
