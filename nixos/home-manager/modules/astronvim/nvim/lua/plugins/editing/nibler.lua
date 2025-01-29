-- Change a given number base between binary, decimal and hexadecimal

local prefix = "<leader>u"

---@type LazySpec
return {
	"skosulor/nibbler",
	event = "VeryLazy",
	keys = {
		{ prefix, desc = "Unit conversion" },
		{ prefix .. "b", "<cmd>NibblerToBin<cr>", desc = "to binary" },
		{ prefix .. "d", "<cmd>NibblerToDec<cr>", desc = "to decimal" },
		{ prefix .. "h", "<cmd>NibblerToHex<cr>", desc = "to hex" },
	},
}
