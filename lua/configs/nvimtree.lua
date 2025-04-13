local api = require "nvim-tree.api"
local map = vim.keymap.set

local function opts(desc, bufnr)
  return { buffer = bufnr, noremap = true, silent = true, desc = "nvim-tree: " .. desc }
end

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

-- Multi files operations
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
    vim.ui.input({ prompt = string.format("Trash %s files/dirs? [y/n] ", #marks) }, function(input)
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
    vim.ui.input({ prompt = string.format("Remove %s files/dirs? [y/n] ", #marks) }, function(input)
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

  local mark_move = function(copy)
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    local file_src = marks[1].absolute_path
    local from_dir = vim.fn.fnamemodify(file_src, ":h") .. "/"

    vim.ui.input({ prompt = string.format("Move %s files to: ", #marks), default = from_dir }, function(input)
      if input then
        local to_dir = vim.fn.fnamemodify(input, ":h") .. "/"
        vim.fn.system { "mkdir", "-p", to_dir }

        for _, node in pairs(marks) do
          local file = node.absolute_path
          if copy then
            vim.fn.system { "cp", "-R", file, to_dir }
          else
            vim.fn.system { "mv", file, to_dir }
          end
        end

        api.marks.clear()
        api.tree.reload()
      end
    end)
  end

  map("n", "<Esc>", api.marks.clear, opts("Tree: Clear Marks", bufnr))

  map("n", "p", api.fs.paste, opts("Tree: Paste", bufnr))
  map("n", "J", mark_move_j, opts("Tree: Toggle Bookmark Down", bufnr))
  map("n", "K", mark_move_k, opts("Tree: Toggle Bookmark Up", bufnr))

  map("n", "x", mark_cut, opts("Tree: Cut File(s)", bufnr))
  map("n", "tr", mark_trash, opts("Tree: Trash File(s)", bufnr))
  map("n", "d", mark_remove, opts("Tree: Remove File(s)", bufnr))
  map("n", "c", mark_copy, opts("Tree: Copy File(s)", bufnr))

  map("n", "mv", function()
    mark_move(false)
  end, opts("Tree: Move To File(s)", bufnr))
  map("n", "cp", function()
    mark_move(true)
  end, opts("Tree: Copy To File(s)", bufnr))
end

-- Vim-like navigation
local function vim_like_navigation(bufnr)
  api.config.mappings.default_on_attach(bufnr)

  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      api.node.open.edit()
    else
      api.node.open.edit()
      api.tree.close()
    end
  end

  local function open_buffer_silent()
    api.node.open.edit()
    api.tree.focus()
  end

  map("n", "l", edit_or_open, opts("Tree: Open File or Folder", bufnr))
  map("n", "L", open_buffer_silent, opts("Tree: Open File Silently", bufnr))
  map("n", "h", api.node.navigate.parent_close, opts("Tree: Close Directory", bufnr))
  map("n", "H", api.tree.collapse_all, opts("Tree: Collapse", bufnr))
end

local function on_attach(bufnr)
  vim_like_navigation(bufnr)
  multi_operations(bufnr)
end

---@type NvimTreeConfig
local options = {
  view = {
    width = { min = 30, max = 50 },
    side = "right",
  },
  git = {
    ignore = false,
    timeout = 1000,
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
  ui = {
    confirm = {
      remove = false,
      trash = false,
    },
  },
  on_attach = on_attach,
}

return options
