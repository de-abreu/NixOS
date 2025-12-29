return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      window = {
        mappings = {
          ["s"] = false,
          ["S"] = false,
          ["-"] = "open_split",
          ["\\"] = "open_vsplit",
        },
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      keymaps = {
        ["C-v"] = false,
        ["\\"] = "actions.jump_vsplit",
        ["-"] = "actions.jump_split",
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-W>-"] = { "<C-w>t<C-w>K", desc = "Rearrange windows horizontally" },
          ["<C-W>i"] = { "<C-w>t<C-w>H", desc = "Rearrange windows vertically" },
        },
      },
    },
  },
}
