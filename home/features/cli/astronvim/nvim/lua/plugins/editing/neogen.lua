return {
  "danymat/neogen",
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { Neogen = "󰷉" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>A"
        local icon = require("astroui").get_icon("Neogen", 1, true)
        maps.n[prefix] = { desc = icon .. "Annotation" }
        maps.n[prefix .. "<CR>"] = {
          function()
            require("neogen").generate { type = "any" }
          end,
          desc = "Current",
        }
        maps.n[prefix .. "c"] = {
          function()
            require("neogen").generate { type = "class" }
          end,
          desc = "Class",
        }
        maps.n[prefix .. "f"] = {
          function()
            require("neogen").generate { type = "func" }
          end,
          desc = "Function",
        }
        maps.n[prefix .. "t"] = {
          function()
            require("neogen").generate { type = "type" }
          end,
          desc = "Type",
        }
        maps.n[prefix .. "F"] = {
          function()
            require("neogen").generate { type = "file" }
          end,
          desc = "File",
        }
      end,
    },
  },
  cmd = "Neogen",
  opts = {
    snippet_engine = "luasnip",
    languages = function()
      local apply = function(name)
        return { template = { annotation_convention = name } }
      end
      return {
        javascript = apply "jsdoc",
        javascriptreact = apply "jsdoc",
        lua = apply "ldoc",
        ruby = apply "yard",
        typescript = apply "tsdoc",
        typescriptreact = apply "tsdoc",
        python = apply "google_docstrings",
        c = apply "doxygen",
      }
    end,
  },
}
