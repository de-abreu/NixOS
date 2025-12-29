---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    local unique = require("astrocore").list_insert_unique
    opts.servers = unique(opts.servers, { "hyprls" })
  end,
}
