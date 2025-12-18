-- INFO: Change a given number base between binary, decimal and hexadecimal

---@type LazySpec
return {
  "skosulor/nibbler",
  event = "BufRead",
  keys = function()
    local prefix = "<leader>u"
    return {
      { prefix, desc = "Unit conversion" },
      { prefix .. "b", "<cmd>NibblerToBin<cr>", desc = "to binary" },
      { prefix .. "d", "<cmd>NibblerToDec<cr>", desc = "to decimal" },
      { prefix .. "h", "<cmd>NibblerToHex<cr>", desc = "to hex" },
    }
  end,
}
