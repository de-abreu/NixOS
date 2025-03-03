---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "nvim-neorg/neorg",
    version = "^8",
    event = "VeryLazy",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          local unique = require("astrocore").list_insert_unique
          local ensure_installed = opts.ensure_installed
          ensure_installed = unique(ensure_installed, { "norg" })
        end
      end,
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.keybinds"] = {}, -- Adds default keybindings
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        }, -- Enables support for completion plugins
        ["core.journal"] = {}, -- Enables support for the journal module
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/projects/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    },
  },
  ---@type LazyPluginSpec
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = { neorg = { "vale" } } },
  },
}
