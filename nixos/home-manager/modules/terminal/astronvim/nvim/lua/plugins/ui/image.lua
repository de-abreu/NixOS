---@type LazySpec
return {
  "3rd/image.nvim",

  -- NOTE: build is set to false cause we won't use Lazy's installation of the
  -- lua rock magick. Instead we use the cli tool to manipulate images
  build = false,
  ft = { "markdown", "tex", "norg", "ipynb", "quarto" },
  processor = "magick_cli",
  specs = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed =
            require("astrocore").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
        end
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        window = {
          mappings = {
            P = {
              "toggle_preview",
              config = { use_image_nvim = true },
            },
          },
        },
      },
    },
  },
  opts = {
    integrations = {
      markdown = {
        only_render_image_at_cursor = true,
        floating_windows = true,
      },
    },
  },
}
