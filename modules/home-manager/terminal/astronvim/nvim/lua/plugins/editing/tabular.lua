-- INFO: Tabularize text with the command ":Tabularize /|", where "|" is an example of a selected separator

---@type LazySpec
return {
  "godlygeek/tabular",
  event = "BufNew",
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        v = {
          ["<Leader>t"] = { ":Tabularize /", desc = "Tabularize" },
        },
      },
    },
  },
}
