-- INFO: Allows cursor to "hop" through the screen by typing given character sequences

---@type LazySpec
return {
  "ggandor/lightspeed.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    -- NOTE: Manually set key bindings to avoid conflicting with other plugins
    opts = { options = { g = { lightspeed_no_default_keymaps = true } } },
  },
  specs = {
    {
      "gbprod/cutlass.nvim",
      opts = function(_, opts)
        opts.exclude = { "ns", "nS" }
      end,
    },
  },
  keys = {
    {
      "f",
      "<Plug>Lightspeed_f",
      desc = "Move to next occurence of character",
      mode = { "n", "o", "x" },
    },
    {
      "F",
      "<Plug>Lightspeed_F",
      desc = "Move to previous occurence of character",
      mode = { "n", "o", "x" },
    },
    {
      "t",
      "<Plug>Lightspeed_t",
      desc = "Move before next occurence of character",
      mode = { "n", "o", "x" },
    },
    {
      "T",
      "<Plug>Lightspeed_T",
      desc = "Move before previous occurence of character",
      mode = { "n", "o", "x" },
    },
    {
      "gs",
      "<Plug>Lightspeed_omni_gs",
      desc = "Move to character in another split",
      mode = { "n", "o", "x" },
    },
    {
      "s",
      "<Plug>Lightspeed_x",
      desc = "Move forwards till following character",
      mode = { "n", "o", "x" },
    },
    {
      "S",
      "<Plug>Lightspeed_S",
      desc = "Move backwards till given character",
      mode = { "n", "o", "x" },
    },
  },
}
