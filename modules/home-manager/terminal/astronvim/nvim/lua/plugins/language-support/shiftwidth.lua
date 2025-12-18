return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      shiftwidth = {
        event = { "AstroFile" },
        pattern = { "*.lua", "*.nix", "*.md", "*.tex" },
        desc = "Set shiftwidth locally",
        callback = function()
          vim.opt_local.shiftwidth = 2
        end,
      },
    },
  },
}
