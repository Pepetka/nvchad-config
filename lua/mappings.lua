require "nvchad.mappings"

local neotest = require "neotest"

local map = vim.keymap.set
local del = vim.keymap.del

local function opts(desc, params)
  params = params or {}
  local expr = params.expr == nil and false or params.expr
  local silent = params.silent == nil and true or params.silent
  local noremap = params.noremap == nil and true or params.noremap
  return { noremap = noremap, silent = silent, expr = expr, desc = desc }
end

-- Basic
map("n", ";", ":", opts("CMD enter command mode", { silent = false }))

map("i", "jk", "<ESC>", opts "Escape")
map("i", "jj", "<ESC>", opts "Escape")

map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, opts("Codeium: Accept Codeium", { expr = true }))
map("i", "<M-j>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, opts("Codeium: Cycle Completions", { expr = true }))
map("i", "<M-k>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, opts("Codeium: Cycle Completions", { expr = true }))
map("i", "<c-x>", function()
  return vim.fn["codeium#Clear"]()
end, opts("Codeium: Clear", { expr = true }))

map("i", "<C-Space>", function()
  require("cmp").complete()
end, opts "Call Autocomplete")

map("v", "J", ":m '>+1<CR>gv=gv", opts "Swap line down")
map("v", "K", ":m '>-1<CR>gv=gv", opts "Swap line up")

map("v", "H", "<gv", opts "Indent left")
map("v", "L", ">gv", opts "Indent right")

-- Buffer
map("n", "<leader>w", "<cmd>wa<CR>", opts "Save All")
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, opts "Close all buffers")

local buffer_mode_active = false
local function toggle_buffer_mode()
  if buffer_mode_active then
    del("n", "h")
    del("n", "l")
    del("n", "H")
    del("n", "L")
    del("n", "d")
    del("n", "q")
    buffer_mode_active = false
    print "Буферный режим выключен"
  else
    map("n", "h", function()
      require("nvchad.tabufline").prev()
    end, opts "Buffer Mode: Previous Buffer Right")
    map("n", "l", function()
      require("nvchad.tabufline").next()
    end, opts "Buffer Mode: Next Buffer Left")
    map("n", "H", function()
      require("nvchad.tabufline").move_buf(-1)
    end, opts "Buffer Mode: Move Buffer Left")
    map("n", "L", function()
      require("nvchad.tabufline").move_buf(1)
    end, opts "Buffer Mode: Move Buffer Right")
    map("n", "q", toggle_buffer_mode, opts "Buffer Mode: Close Buffer Mode")
    buffer_mode_active = true
    print "Буферный режим включен"
  end
end

map("n", "<leader>bm", toggle_buffer_mode, opts "Toggle Buffer Mode")

-- Tmux
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", opts "Tmux Right")
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", opts "Tmux Left")
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", opts "Tmux Up")
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", opts "Tmux Down")

-- Translate
map("v", "<leader>te", ":Translate EN<CR>", opts "Translate (en)")
map("v", "<leader>tr", ":Translate RU<CR>", opts "Translate (ru)")
map("v", "<leader>to", ":Translate EN --output=replace<CR>", opts "Translate (en) and replace")

-- Tests
map("n", "<leader>tt", function()
  neotest.run.run()
end, opts "Run nearest test")
map("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand "%")
end, opts "Run test file")
map("n", "<leader>to", ":Neotest output<CR>", opts "Show test output")
map("n", "<leader>ts", ":Neotest summary<CR>", opts "Show test summary")

-- Trouble
map("n", "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", opts "Open Workspace Trouble")
map("n", "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts "Open Document Trouble")
map("n", "<leader>qq", "<cmd>Trouble qflist toggle<cr>", opts "Open Quickfix")
map("n", "<leader>qt", "<cmd>TodoQuickFix<CR>", opts "Open Todo Trouble")

map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", opts "Telescope Todo")

-- Git
map("n", "<leader>gl", ":Flog<CR>", opts "Git Log")
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", opts "Git File History")
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", opts "Git Diff Toggle File")
map("n", "<leader>go", ":DiffviewOpen<CR>", opts "Git Diff Open")
map("n", "<leader>gc", ":DiffviewClose<CR>", opts "Git Diff Close")

-- Debug
map("n", "<leader>du", function()
  require("dapui").toggle()
end, opts "Toggle Debug UI")
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, opts "Toggle Breakpoint")
map("n", "<leader>ds", function()
  require("dap").continue()
end, opts "Debug Start")
map("n", "<leader>dO", function()
  require("dap").step_out()
end, opts "Debug Step Out")
map("n", "<leader>do", function()
  require("dap").step_over()
end, opts "Debug Step Over")

-- Terminal
map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, opts "Toogle Terminal Vertical")
map("n", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, opts "Toogle Terminal Horizontal")
map("n", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, opts "Toogle Terminal Float")
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end, opts "Toogle Terminal Vertical")
map("t", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp" }
end, opts "Toogle Terminal Horizontal")
map("t", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, opts "Toogle Terminal Float")
