return {
  {
    {
      "AstroNvim/astrocore",
      opts = {
        filetypes = {
          extension = {
            pg = "sql",
          },
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sql" })
        end
      end,
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      local unique = require("astrocore").list_insert_unique

      opts.servers = unique(opts.servers, { "sqls" })
      opts.config = {
        sqls = {
          on_attach = function(client)
            -- Disable formatting due to bugs: https://github.com/sqls-server/sqls/issues/149
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.handlers = {
        sqlfluff = function()
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with {
            extra_args = { "--dialect", "postgres" },
          })
          null_ls.register(null_ls.builtins.formatting.sqlfluff.with {
            extra_args = { "--dialect", "postgres" },
          })
        end,
      }
    end,
  },
  {
    "nanotee/sqls.nvim",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          sqls_attach = {
            {
              event = "LspAttach",
              desc = "Load sqls.nvim with sqls",
              callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if client.name == "sqls" then
                  require("sqls").on_attach(client, args.buf)
                end
              end,
            },
          },
        },
      },
    },
  },
}
