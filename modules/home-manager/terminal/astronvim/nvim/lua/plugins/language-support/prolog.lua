local unique = require("astrocore").list_insert_unique

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local servers = opts.servers
      servers = unique(servers, { "prolog_ls" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local ensure_installed = opts.ensure_installed
      ensure_installed = unique(ensure_installed, { "prolog" })
    end,
  },
}
