local unique = require("astrocore").list_insert_unique

---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = unique(opts.ensure_installed, { "nix" })
      end
    end,
  },
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      local servers = opts.servers
      servers = unique(servers, { "nixd" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix", "deadnix" },
      },
    },
  },
  ---@type LazyPluginSpec
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local builtins = require("null-ls").builtins
      local sources = opts.sources
      sources = unique(sources, {
        builtins.formatting.alejandra,
        builtins.code_actions.statix,
        builtins.diagnostics.deadnix,
      })
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        lua_shiftwidth = {
          event = "FileType",
          pattern = "nix",
          desc = "Set shiftwidth locally for nix files",
          callaback = function()
            vim.opt_local.shiftwidth = 2
          end,
        },
      },
    },
  },
}
