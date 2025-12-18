local is_available = function(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return (lazy_config_avail and lazy_config.spec.plugins[plugin] or nil) ~= nil
end
local haskell_ft = { "haskell", "lhaskell", "cabal", "cabalproject" }

---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local unique = require("astrocore").list_insert_unique
      opts.servers = unique(opts.servers, { "hls" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "mrcjkb/haskell-snippets.nvim",
    enabled = function()
      return is_available "LuaSnip"
    end,
    ft = haskell_ft,
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "mrcjkb/haskell-tools.nvim",
    ft = haskell_ft,
    dependencies = {
      -- vim.fn.has >= nvim 0.9 removes plenary dependency
      { "nvim-lua/plenary.nvim", optional = vim.fn.has "nvim-0.9" == 1 },
      { "nvim-telescope/telescope.nvim", optional = true },
      { "mfussenegger/nvim-dap", optional = true },
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          handlers = { hls = false },
        },
      },
    },
    version = "^4",
    init = function()
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      vim.g.haskell_tools = require("astrocore").extend_tbl({
        hls = astrolsp_avail and { capabilities = astrolsp.config.capabilities, on_attach = astrolsp.on_attach } or {},
      }, vim.g.haskell_tools)
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "mrcjkb/neotest-haskell",
      ft = haskell_ft,
      config = function() end,
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require "neotest-haskell"(require("astrocore").plugin_opts "neotest-haskell"))
    end,
  },
  ---@type LazyPluginSpec
  {
    "luc-tielen/telescope_hoogle",
    enabled = function()
      return is_available "telescope.nvim"
    end,
    ft = haskell_ft,
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension "hoogle"
      end
    end,
  },
  ---@type LazyPluginSpec
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      for _, ft in ipairs(haskell_ft) do
        opts.linters_by_ft[ft] = { "hlint" }
      end
    end,
  },
}
