return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        lua_shiftwidth = {
          event = "FileType",
          pattern = "lua",
          desc = "Set shiftwidth locally for lua files",
          callaback = function()
            vim.opt_local.shiftwidth = 2
          end,
        },
      },
    },
  },
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
  },
}
