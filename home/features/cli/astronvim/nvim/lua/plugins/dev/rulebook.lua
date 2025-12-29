local prefix = "<Leader>l"

return {
  "chrisgrieser/nvim-rulebook",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local rb = require "rulebook"
        opts.mappings = require("astrocore").extend_tbl(opts.mappings, {
          n = {
            [prefix .. "i"] = {
              function()
                rb.ignoreRule()
              end,
              desc = "LSP ignore warning",
            },
            [prefix .. "q"] = {
              function()
                rb.lookupRule()
              end,
              desc = "query rule",
            },
            [prefix .. "y"] = {
              function()
                rb.yankDiagnosticCode()
              end,
              desc = "yank diagnostic code",
            },
            [prefix .. "F"] = {
              function()
                rb.suppressFormatter()
              end,
              desc = "suppress inline formatting",
            },
          },
          v = {
            [prefix .. "F"] = {
              function()
                rb.suppressFormatter()
              end,
              desc = "suppress formatting",
            },
          },
        })
      end,
    },
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local map = opts.mappings
        map.n[prefix .. "i"] = false
        map.n[prefix .. "Q"] = {
          "<Cmd>LspInfo<CR>",
          cond = function()
            return vim.fn.exists ":LspInfo" > 0
          end,
          desc = "LSP information",
        }
      end,
    },
  },
}
