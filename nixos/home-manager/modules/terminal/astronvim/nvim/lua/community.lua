-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  -- Highlight other instances of the word under the cursor
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- Context aware commenting for embedded languages
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- Display a list of diagnostics and TODOs of the current file
  { import = "astrocommunity.markdown-and-latex.markview-nvim" },
  -- Styling for markdown markers
  { import = "astrocommunity.motion.nvim-spider" },
  -- Similar to CamelCaseMotion, but also with some considerations for punctuation
  { import = "astrocommunity.search.grug-far-nvim" },
  -- Search and replace
  { import = "astrocommunity.test.neotest" },
  -- Conduct tests from within Neovim. TODO: Learn how to conduct tests and use this tool
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  -- Prevent the recursive creation of nvim instances
  { import = "astrocommunity.editing-support.neogen" },
  -- An automated annotation generator
  { import = "astrocommunity.file-explorer.oil-nvim" },
  -- Edit a filesystem like a buffer

  -- NOTE: Image support
  { import = "astrocommunity.media.image-nvim" },
  -- Enable the display of images
  { import = "astrocommunity.media.img-clip-nvim" },
  -- Embed images, either from the clipboard or drag-and-dropped,  into files written in a markup language

  -- NOTE: Code runners
  { import = "astrocommunity.code-runner.vim-slime" },
  -- Send code from python/r/qmd documents to a terminal or REPL
  { import = "astrocommunity.code-runner.molten-nvim" },
  -- WARN: After the installation of this plugin, it *may be* necessary to run the command `:UpdateRemotePlugins` to generate the folder `~/.local/share/nvim/lazy/molten-nvim/rplugin/` with the python plugins specification. See https://github.com/AstroNvim/astrocommunity/issues/1331

  -- NOTE: Debugging
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  -- Add syntax highlighting to the REPL terminal
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- Adds virtual text support

  -- Plugins for language support
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.nix" }, -- Requires nixd, alejandra, deadnix and statix
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.quarto" },
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
}
