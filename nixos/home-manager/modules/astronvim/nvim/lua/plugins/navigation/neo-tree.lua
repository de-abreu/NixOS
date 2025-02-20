-- Function to automatically resize windows upon opening or closing neo-tree
local autoresize = function(args)
  if args.position == "left" or args.position == "right" then
    vim.cmd "wincmd ="
  end
end

-- Allow to search for a filename or string contained in a file using telescope
local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, _)
      local actions = require "telescope.actions"
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

local inputs = require "neo-tree.ui.inputs"

-- Trash a selection
local function trash(state)
  local node = state.tree:get_node()
  if node.type == "message" then
    return
  end
  local _, name = require("neo-tree.utils").split_path(node.path)
  local msg = string.format("Are you sure you want to trash '%s'?", name)
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    vim.api.nvim_command("silent !trash " .. node.path)
    require("neo-tree.sources.manager").refresh(state)
  end)
end

-- Trash multiple selections (visual mode)
local function trash_visual(state, selected_nodes)
  local paths_to_trash = {}
  for _, node in ipairs(selected_nodes) do
    if node.type ~= "message" then
      table.insert(paths_to_trash, node.path)
    end
  end
  local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    for _, path in ipairs(paths_to_trash) do
      vim.api.nvim_command("silent !trash " .. path)
    end
    require("neo-tree.sources.manager").refresh(state)
  end)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      opts = {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "nofile" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix", "nofile" },
          },
        },
        show_prompt = false,
      },
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = autoresize,
      },
      {
        event = "neo_tree_window_after_close",
        handler = autoresize,
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
      end,
      trash = trash,
      trash_visual = trash_visual,
    },
    window = {
      mappings = {
        H = "prev_source",
        ["<S-Ç>"] = "next_source",
        ["ç"] = "open_with_window_picker",
        h = "close_node",
        u = "toggle_hidden",
        P = {
          "toggle_preview",
          config = { use_image_nvim = true },
        },
        d = "trash",
      },
    },
    buffers = {
      follow_current_file = { enabled = true },
    },
    filesystem = {
      window = {
        mappings = {
          ["tf"] = "telescope_find",
          ["tg"] = "telescope_grep",
        },
      },
      filtered_items = {
        hide_by_name = {
          "node_modules",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
  },
}
