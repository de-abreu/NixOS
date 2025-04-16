return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- Context aware commenting for embedded languages. i.e. code inside a markdown file
  { import = "astrocommunity.test.neotest" },
  -- Conduct tests from within Neovim.
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  -- Prevent the recursive creation of nvim instances
  { import = "astrocommunity.editing-support.neogen" },
  -- An automated annotation generator
  { import = "astrocommunity.editing-support.undotree" },
  -- Makes the document history a branching tree, and enables navigating it.
  { import = "astrocommunity.media.img-clip-nvim" },
  -- Embed images, either from the clipboard or drag-and-dropped, into files
  -- written in a markup language
}
