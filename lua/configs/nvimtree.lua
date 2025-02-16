local api = require "nvim-tree.api"
local map = vim.keymap.set
local view_width = 30

local function refresh()
  api.tree.reload()
  api.tree.close()
  api.tree.focus()
end

local function on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)
  map("n", "H", function()
    view_width = math.max(view_width - 2, 30)
    refresh()
  end, { noremap = true, silent = true, desc = "Reduce width nvim-tree", buffer = bufnr })

  map("n", "L", function()
    view_width = math.min(view_width + 2, 50)
    refresh()
  end, { noremap = true, silent = true, desc = "Reduce width nvim-tree", buffer = bufnr })
end

local function get_width()
  return view_width
end

local options = {
  view = {
    width = get_width,
  },
  git = {
    ignore = false,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  on_attach = on_attach,
}

return options
