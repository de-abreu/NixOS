-- INFO: Search and replace functionality
return {
  {
    "MagicDuck/grug-far.nvim",
    version = "1.6.3", -- NOTE: Workaround, see: https://github.com/MagicDuck/grug-far.nvim/issues/456
  },
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.search.grug-far-nvim" },
  },
}
