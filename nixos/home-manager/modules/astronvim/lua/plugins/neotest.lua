---@type LazySpec
return {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "mrcjkb/neotest-haskell", config = function() end },
    opts = function(_, opts)
        if not opts.adapters then
            opts.adapters = {}
        end
        table.insert(opts.adapters, require("neotest-haskell")(require("astrocore").plugin_opts("neotest-haskell")))
    end,
}
