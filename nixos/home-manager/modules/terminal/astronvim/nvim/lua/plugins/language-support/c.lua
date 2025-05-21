-- TODO: Create a nix module and have it create the .clang-format file at $HOME
local unique = require("astrocore").list_insert_unique

---@type LazySpec
return {
  ---@type LazyPluginSpec
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.config = {
        clangd = {
          capabilities = {
            cmd = { "clangd" },
            offsetEncoding = "utf-8",
          },
        },
      }
      opts.servers = unique(opts.servers, { "clangd" })
    end,
  },
  ---@type LazyPluginSpec
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = unique(opts.ensure_installed, { "cpp", "c", "objc", "cuda", "proto" })
      end
    end,
  },
  ---@type LazyPluginSpec
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          clangd_extensions = {
            {
              event = "LspAttach",
              desc = "Load clangd_extensions with clangd",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                  require "clangd_extensions"
                  vim.api.nvim_del_augroup_by_name "clangd_extensions"
                end
              end,
            },
          },
          clangd_extension_mappings = {
            {
              event = "LspAttach",
              desc = "Load clangd_extensions with clangd",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                  require("astrocore").set_mappings({
                    n = {
                      ["<Leader>lw"] = { "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header file" },
                    },
                  }, { buffer = args.buf })
                end
              end,
            },
          },
        },
      },
    },
  },
  ---@type LazyPluginSpec
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = unique(opts.ensure_installed, { "codelldb" })
        end,
      },
    },
    opts = {},
  },
  ---@type LazyPluginSpec
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = unique(opts.sources, {
        null_ls.builtins.formatting.clang_format,
      })
    end,
  },
}
