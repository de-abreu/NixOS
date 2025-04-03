return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      lua_shiftwidth = {
        event = "FileType",
        pattern = { "lua", "nix", "markdown", "tex" },
        desc = "Set shiftwidth locally for lua files",
        callaback = function()
          vim.opt_local.shiftwidth = 2
        end,
      },
    },
  },
}
