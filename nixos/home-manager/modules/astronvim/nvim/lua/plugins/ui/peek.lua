---@type LazySpec
return {
  "toppair/peek.nvim",
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
    {
      "AstroNvim/astrocore",
      optional = true,
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>M"

        maps.n[prefix] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" }
        maps.n[prefix .. "p"] = {
          function()
            local peek = require "peek"
            if peek.is_open() then
              peek.close()
            else
              peek.open()
            end
          end,
          desc = "Toggle preview",
        }
      end,
    },
  },
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  opts = {
    theme = "light",
    app = "chromium",
  },
}
