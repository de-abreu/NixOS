local categories = {
  "core",
  "dev",
  "editing",
  "git",
  "language-support",
  "navigation",
  "ui",
  "utility",
}
local plugins = {}

for _, category in ipairs(categories) do
  table.insert(plugins, { import = "plugins." .. category })
end
--- @type LazySpec
return plugins
