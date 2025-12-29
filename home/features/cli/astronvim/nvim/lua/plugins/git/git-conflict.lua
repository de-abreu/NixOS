-- INFO: A plugin to visualize and resolve conflicts in neovim

--[[ NOTE: Default mappings

- co — choose ours
- ct — choose theirs
- cb — choose both
- c0 — choose none
- ]x — move to previous conflict
- [x — move to next conflict
]]

---@type LazySpec
return {
  "akinsho/git-conflict.nvim",
  event = "BufRead",
  version = "*",
  config = true,
}
