local api = require "nvim-tree.api"

-- Autoclose nvimtree after quit
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match "NvimTree_" ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= "" then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- Automatically open file upon creation
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
end)

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    api.node.open.edit()
  else
    api.node.open.edit()
    api.tree.close()
  end
end

local function vsplit_preview()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    api.node.open.edit()
  else
    api.node.open.vertical()
  end

  api.tree.focus()
end

local function opts(desc, bufnr)
  return { buffer = bufnr, noremap = true, silent = true, desc = "nvim-tree: " .. desc }
end

-- Multi operations
local function multi_operations(bufnr)
  -- mark operation
  local mark_move_j = function()
    api.marks.toggle()
    vim.cmd "norm j"
  end
  local mark_move_k = function()
    api.marks.toggle()
    vim.cmd "norm k"
  end

  -- marked files operation
  local mark_trash = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #marks) }, function(input)
      if input == "y" then
        for _, node in ipairs(marks) do
          api.fs.trash(node)
        end
        api.marks.clear()
        api.tree.reload()
      end
    end)
  end
  local mark_remove = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    vim.ui.input({ prompt = string.format("Remove %s files? [y/n] ", #marks) }, function(input)
      if input == "y" then
        for _, node in ipairs(marks) do
          api.fs.remove(node)
        end
        api.marks.clear()
        api.tree.reload()
      end
    end)
  end

  local mark_copy = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    for _, node in pairs(marks) do
      api.fs.copy.node(node)
    end
    api.marks.clear()
    api.tree.reload()
  end
  local mark_cut = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    for _, node in pairs(marks) do
      api.fs.cut(node)
    end
    api.marks.clear()
    api.tree.reload()
  end

  vim.keymap.set("n", "p", api.fs.paste, opts("Paste", bufnr))
  vim.keymap.set("n", "J", mark_move_j, opts("Toggle Bookmark Down", bufnr))
  vim.keymap.set("n", "K", mark_move_k, opts("Toggle Bookmark Up", bufnr))

  vim.keymap.set("n", "cu", mark_cut, opts("Cut File(s)", bufnr))
  vim.keymap.set("n", "tr", mark_trash, opts("Trash File(s)", bufnr))
  vim.keymap.set("n", "rm", mark_remove, opts("Remove File(s)", bufnr))
  vim.keymap.set("n", "cp", mark_copy, opts("Copy File(s)", bufnr))

  vim.keymap.set("n", "mv", api.marks.bulk.move, opts("Move Bookmarked", bufnr))
end

local function vimlike_navigation(bufnr)
  local map = vim.keymap.set

  api.config.mappings.default_on_attach(bufnr)

  map("n", "l", edit_or_open, opts("Open File or Folder", bufnr))
  map("n", "L", vsplit_preview, opts("Vsplit Preview", bufnr))
  map("n", "h", api.node.navigate.parent_close, opts("Close Directory", bufnr))
  map("n", "H", api.tree.collapse_all, opts("Collapse", bufnr))
end

local function on_attach(bufnr)
  vimlike_navigation(bufnr)
  multi_operations(bufnr)
end

local options = {
  view = {
    width = { min = 30, max = 50 },
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
