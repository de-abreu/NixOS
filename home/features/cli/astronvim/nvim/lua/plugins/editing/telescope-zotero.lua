---@type LazySpec
return {
  "jmbuhr/telescope-zotero.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
  config = function()
    local root = "~/Documents/Zotero/"
    require("zotero").setup {
      zotero_db_path = root .. "zotero.sqlite",
      better_bibtex_db_path = root .. "better-bibtex.sqlite",
      zotero_storage_path = root .. "storage",
    }
    require("telescope").load_extension "zotero"
  end,
  keys = { { "<leader>fz", "<cmd>Telescope zotero<cr>", desc = "Zotero" } },
}
