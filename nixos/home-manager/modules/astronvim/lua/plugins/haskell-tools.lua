local haskell_ft = { "haskell", "lhaskell", "cabal", "cabalproject" }

return {
    "mrcjkb/haskell-tools.nvim",
    ft = haskell_ft,
    dependencies = {
        -- vim.fn.has >= nvim 0.9 removes plenary dependency
        { "nvim-lua/plenary.nvim",         optional = vim.fn.has("nvim-0.9") == 1 },
        { "nvim-telescope/telescope.nvim", optional = true },
        { "mfussenegger/nvim-dap",         optional = true },
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
            hls = astrolsp_avail and { capabilities = astrolsp.config.capabilities, on_attach = astrolsp.on_attach }
                or {},
        }, vim.g.haskell_tools)
    end,
}
