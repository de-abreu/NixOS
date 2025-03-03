-- TODO: Learn how to use this tool

---@type LazySpec
return {
  "nvim-neotest/neotest",
  optional = true,
  keys = {
    {
      "<leader>Ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop test",
    },
  },
}
