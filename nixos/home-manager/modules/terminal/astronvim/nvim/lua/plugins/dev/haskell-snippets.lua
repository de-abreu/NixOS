local is_available = function(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return (lazy_config_avail and lazy_config.spec.plugins[plugin] or nil) ~= nil
end
local haskell_ft = { "haskell", "lhaskell", "cabal", "cabalproject" }

---@type LazySpec
return {
    "mrcjkb/haskell-snippets.nvim",
    enabled = function()
        return is_available("LuaSnip")
    end,
    ft = haskell_ft,
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
        local haskell_snippets = require("haskell-snippets").all
        require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
}
