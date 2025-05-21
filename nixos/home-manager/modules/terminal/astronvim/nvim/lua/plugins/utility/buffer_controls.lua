return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<Left>"] = {
          function()
            require("astrocore.buffer").nav(-vim.v.count1)
          end,
          desc = "Previous buffer",
        },
        ["<Right>"] = {
          function()
            require("astrocore.buffer").nav(vim.v.count1)
          end,
          desc = "Next buffer",
        },
        ["<Leader>b-"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.split()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Horizontal split buffer from tabline",
        },
        ["<Leader>b\\"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.vsplit()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end,
          desc = "Vertical split buffer from tabline",
        },
        ["<Leader>b|"] = false,
      },
    },
  },
}
