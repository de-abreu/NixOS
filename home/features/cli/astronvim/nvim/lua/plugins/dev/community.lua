---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Autocompletion and suggestions
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- Display a list of diagnostics and TODOs of the current file
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  -- Utilities to manipulate Latex files

  -- NOTE: Code runners
  { import = "astrocommunity.code-runner.vim-slime" },
  -- Send code from python/r/qmd documents to a terminal or REPL
  { import = "astrocommunity.code-runner.molten-nvim" },
  -- WARN: After the installation of this plugin, it *may be* necessary to run the command `:UpdateRemotePlugins` to generate the folder `~/.local/share/nvim/lazy/molten-nvim/rplugin/` with the python plugins specification. See https://github.com/AstroNvim/astrocommunity/issues/1331
}
