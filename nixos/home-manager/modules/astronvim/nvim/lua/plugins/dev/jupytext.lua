-- INFO: Allows for opening ipynb as quarto documents

---@type LazySpec
return {
    "GCBallesteros/jupytext.nvim",
    ft = { "ipynb" },
    opts = {
        custom_language_formatting = {
            python = {
                extension = "qmd",
                style = "quarto",
                force_ft = "quarto",
            },
            r = {
                extension = "qmd",
                style = "quarto",
                force_ft = "quarto",
            },
        },
    },
}
