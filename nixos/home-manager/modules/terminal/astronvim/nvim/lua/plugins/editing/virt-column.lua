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
            desc = "Set a textwidth limit only for code",
            callback = function()
              local filetypes = {
                "markdown",
                "plaintex",
                "quarto",
                "norg",
                "tex",
                "text",
                "typst",
              }
              for _, ft in ipairs(filetypes) do
                if ft == vim.bo.filetype then
                  return
                end
              end
              vim.opt_local.textwidth = 80
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
