-- Allow editing files by their hexadecimal values.
-- NOTE: Requires 'xxd' to be installed. Try to install it trough the packages xxd-standalone or tinyxxd.

local disable = function()
	return false
end

return {
	"RaafatTurki/hex.nvim",
	event = "VeryLazy",

	-- Disable automatic conversion from binary
	config = true,
	opts = {
		is_file_binary_pre_read = disable,
		is_file_binary_post_read = disable,
	},
}
