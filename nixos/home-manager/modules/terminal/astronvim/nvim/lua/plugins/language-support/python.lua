return {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.pack.python-ruff" } },
  { "nvim-neotest/neotest", optional = true, adapters = require "neotest-python" { runner = "unittest" } },
}
