return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local map = opts.mappings
    local function split_with_buffer_picker(split_cmd)
      local buffers = vim.tbl_filter(function(bufnr)
        return vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      end, vim.api.nvim_list_bufs())
      if #buffers == 1 then
        vim.cmd(split_cmd)
      else
        require("astroui.status.heirline").buffer_picker(function(bufnr)
          vim.cmd(split_cmd)
          vim.api.nvim_win_set_buf(0, bufnr)
        end)
      end
    end

    map.n = require("astrocore").extend_tbl(map.n, {
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
      ["-"] = {
        function()
          split_with_buffer_picker "split"
        end,
        desc = "Horizontal split buffer from tabline",
      },
      ["\\"] = {
        function()
          split_with_buffer_picker "vsplit"
        end,
        desc = "Vertical split buffer from tabline",
      },
      ["<Leader>b|"] = false,
    })
  end,
}
