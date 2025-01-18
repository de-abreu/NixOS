local is_available = function(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return (lazy_config_avail and lazy_config.spec.plugins[plugin] or nil) ~= nil
end
local haskell_ft = { "haskell", "lhaskell", "cabal", "cabalproject" }

---@type LazySpec
return {
    "luc-tielen/telescope_hoogle",
    enabled = function()
        return is_available("telescope.nvim")
    end,
    ft = haskell_ft,
    dependencies = {
        { "nvim-telescope/telescope.nvim" },
    },
    config = function()
        local ok, telescope = pcall(require, "telescope")
        if ok then
            telescope.load_extension("hoogle")
        end
    end,
}
