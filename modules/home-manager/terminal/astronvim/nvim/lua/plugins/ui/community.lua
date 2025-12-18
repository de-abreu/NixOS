---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  -- Highlight other instances of the word under the cursor
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  -- Indent line changes color to indicate the scope
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- Adds virtual text support to the debugger
}
