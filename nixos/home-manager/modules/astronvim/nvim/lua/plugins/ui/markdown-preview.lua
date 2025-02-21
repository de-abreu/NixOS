-- INFO: Preview markdown files in a browser

--- @type LazySpec
return {
  "iamcco/markdown-preview.nvim",

  --INFO: See error: https://github.com/iamcco/markdown-preview.nvim/issues/549
  build = function(plugin)
    local export = "NODE_OPTIONS=--openssl-legacy-provider"
    local cmd = string.format(
      -- bash
      "cd %s && npx --yes yarn install && %s npx --yes yarn build",
      plugin.dir,
      export
    )
    vim.cmd(cmd)
  end,
}
