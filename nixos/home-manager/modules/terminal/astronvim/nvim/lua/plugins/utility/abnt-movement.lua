-- INFO: Configure plugins to use or reserve the keys jklç, instead of the
-- default hjkl, for movement.
-- TODO: Make this file able to assign any key combination to be the new set of
-- movement keys, instead of just the ones asigned to ABNT.

local configurations = {
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      local movement = {
        j = { "h", desc = "Move cursor left", expr = false },
        k = { "j", desc = "Move cursor down", expr = false },
        gk = { "gj", desc = "Move cursor down a visual line", expr = false },
        l = { "k", desc = "Move cursor up" },
        gl = { "gk", desc = "Move cursor up a visual line" },
        ["ç"] = { "l", desc = "Move cursor right" },
        gg = { "gg^", desc = "Move to the beggining of the buffer" },
        G = { "GG$", desc = "Move to the end of the buffer" },
      }
      maps.n["<Leader>j"] = {
        function()
          require("astrocore.buffer").nav(-vim.v.count1)
        end,
        desc = "Previous buffer",
      }
      maps.n["<Leader>ç"] = {
        function()
          require("astrocore.buffer").nav(vim.v.count1)
        end,
        desc = "Next buffer",
      }
      for _, mode in ipairs { "n", "v", "o", "x" } do
        for key, value in pairs(movement) do
          maps[mode][key] = value
        end
      end
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local maps = opts.defaults.mappings.n
      maps.k = actions.move_selection_next
      maps.l = actions.move_selection_previous
      maps["ç"] = actions.select_default
    end,
  },
  ---@type LazyPluginSpec
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      local maps = opts.mapping
      maps["<C-K>"] = cmp.mapping.select_next_item()
      maps["<C-L>"] = cmp.mapping.select_prev_item()
      maps["<CR>"] = cmp.mapping.confirm()
    end,
  },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-K>"] = { "select_next", "fallback" },
        ["<C-L>"] = { "select_prev", "fallback" },
      },
    },
  },
  ---@type LazyPluginSpec
  {
    "mrjones2014/smart-splits.nvim",
    keys = function()
      local plugin = require "smart-splits"
      return {

        -- Resizing splits
        { "<M-j>", plugin.resize_left, desc = "Push vertical border left" },
        { "<M-k>", plugin.resize_down, desc = "Push horizontal border down" },
        { "<M-l>", plugin.resize_up, desc = "Push horizontal border up" },
        { "<M-;>", plugin.resize_right, desc = "Push vertical border right" },

        -- Moving between splits
        { "<C-j>", plugin.move_cursor_left, desc = "Move cursor to left split" },
        { "<C-k>", plugin.move_cursor_down, desc = "Move cursor to split below" },
        { "<C-l>", plugin.move_cursor_up, desc = "Move cursor to split above" },
        { "<C-;>", plugin.move_cursor_right, desc = "Move cursor to right split" },
        { "<C-\\>", plugin.move_cursor_previous, desc = "Move cursor to previous split" },

        -- Swap buffers between splits
        { "J", plugin.swap_buf_left, desc = "Swap current buffer with the one to the left" },
        { "K", plugin.swap_buf_down, desc = "Swap current buffer with the one below" },
        { "L", plugin.swap_buf_up, desc = "Swap current buffer with the one above" },
        { "<S-Ç>", plugin.swap_buf_right, desc = "Swap current buffer with the one to the right" },
      }
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          -- Remapped keys previously associated with hjkl.
          ["ç"] = "open_with_window_picker",
          j = "close_node",
          l = false,
          h = "toggle_hidden",
        },
      },
    },
  },
}

for _, module in ipairs(configurations) do
  module.optional = true
end

---@type LazySpec
return configurations
