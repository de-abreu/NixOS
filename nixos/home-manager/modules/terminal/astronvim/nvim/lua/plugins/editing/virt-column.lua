-- INFO: Set a maximum line length of 80 to hardwrap commentaries when editing
-- code, and place a vertical marker to indicate it.

---@type LazySpec
return {
  "lukas-reineke/virt-column.nvim",
  event = "VeryLazy",
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        auto_textwidth = {
          {
            event = "BufWinEnter",
            desc = "Disable textwidth for plaintext",
            callback = function()
              local ft = vim.bo.filetype
              if not (ft == "" or ft == "text") then
                vim.opt_local.textwidth = 80
              end
            end,
          },
        },
      },
    },
  },
  opts = {
    char = "🭰",
    highlight = "Comment",
    virtcolumn = "+1",
  },
}
