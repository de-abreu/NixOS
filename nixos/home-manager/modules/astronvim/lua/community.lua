-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Highlight other uses of the word under the cursor
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  -- Context aware commenting for embedded languages
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- Add syntax highlighting to the Debug Adapter's REPL terminal
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  -- Display a list of diagnostics and TODOs of the current file
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- Preview markdown documents locally, using the browser
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  -- Styling for markdown markers
  { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  -- Similar to CamelCaseMotion, but also with some considerations for punctuation
  { import = "astrocommunity.motion.nvim-spider" },
  -- Search and replace
  { import = "astrocommunity.search.grug-far-nvim" },
  -- Conduct tests from within Neovim. TODO: Learn how to conduct tests and use this tool
  { import = "astrocommunity.test.neotest" },

  -- Plugins for language support
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.nix" }, -- Requires nixd, alejandra, deadnix and statix
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
}
