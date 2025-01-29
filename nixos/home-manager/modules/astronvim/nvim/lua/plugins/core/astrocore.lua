-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

local opts = {
	-- Configure core features of AstroNvim
	features = {
		large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
		autopairs = true,                           -- enable autopairs at start
		cmp = true,                                 -- enable completion at start
		diagnostics_mode = 3,                       -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
		highlighturl = true,                        -- highlight URLs at start
		notifications = true,                       -- enable notifications at start
	},
	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = true,
		underline = true,
	},
	-- vim options can be configured here
	options = {
		opt = {               -- vim.opt.<key>
			relativenumber = true, -- sets vim.opt.relativenumber
			number = true,    -- sets vim.opt.number
			signcolumn = "yes", -- sets vim.opt.signcolumn to yes
			mouse = "",       -- Disable the mouse
			clipboard = "unnamedplus", -- Enable clipboard access

			-- Localization and spell check options
			langmap = "jklç;hjkl,JKLÇ;HJKL", -- Remappping of the right hand home row to that of the ABNT2 keyboard
			spell = true,           -- sets vim.opt.spell
			spelllang = { "en_us", "pt_br" },
			-- rtp:append("~/.config/nvim/")

			-- Softwrap options
			wrap = true,  -- Enable line wrapping
			linebreak = true, -- Break lines at "breakat" characters, thus not splitting words
			breakindent = true, -- Preserve indentation when breaking lines
			whichwrap = "b,s,h,l", -- Set keys which can make the cursor wrap lines

			-- Set tab length
			shiftwidth = 0, -- Set to zero to return the same value as tabstop
			tabstop = 4,
		},
		g = { -- vim.g.<key>
			-- configure global vim variables (vim.g)
			-- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
			-- This can be found in the `lua/lazy_setup.lua` file
		},
	},
}

local nop = { "<nop>", desc = "No operation" }
local no_operation = {
	["<Down>"] = nop,
	["<End>"] = nop,
	["<Left>"] = nop,
	["<PageDown>"] = nop,
	["<PageUp>"] = nop,
	["<Right>"] = nop,
	["<Up>"] = nop,
}

local vertical_movement = {
	k = { "gk", desc = "Move down a visual line", expr = false },
	l = { "gl", desc = "Move up a visual line" },
	gg = { "gg^", desc = "Move to the beggining of the buffer" },
	G = { "GG$", desc = "Move to the end of the buffer" },
}

local buffer_controls = {
	["<Leader>h"] = {
		function()
			require("astrocore.buffer").nav(-vim.v.count1)
		end,
		desc = "Previous buffer",
	},
	["<Leader>ç"] = {
		function()
			require("astrocore.buffer").nav(vim.v.count1)
		end,
		desc = "Next buffer",
	},
}

local window_controls = {
	["<C-W>-"] = { "<C-w>t<C-w>K", desc = "Rearrange windows horizontally" },
	["<C-W>i"] = { "<C-w>t<C-w>H", desc = "Rearrange windows vertically" },
	["\\"] = { ":vsplit ", desc = "Split window vertically" },
	["-"] = { ":split ", desc = "Split window horizontally" },
}

-- Define the mappings and modes
local custom_mappings = {
	{ modes = { "n", "v", "i", "o" }, mappings = { no_operation } },
	{ modes = { "n", "v" },           mappings = { vertical_movement } },
	{
		modes = { "n" },
		mappings = { window_controls, buffer_controls, { gx = { desc = "Open URL" } } },
	},
}

-- Assign mappings
for _, combination in ipairs(custom_mappings) do
	for _, mode in ipairs(combination.modes) do
		for _, mapping in ipairs(combination.mappings) do
			for key, value in pairs(mapping) do
				opts = require("astrocore").extend_tbl(opts, {
					mappings = {
						[mode] = {
							[key] = value,
						},
					},
				})
			end
		end
	end
end

return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = opts,
}
