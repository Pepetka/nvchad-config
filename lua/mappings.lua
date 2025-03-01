require "nvchad.mappings"

local neotest = require "neotest"

local map = vim.keymap.set
local del = vim.keymap.del

-- Basic
map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape" })
map("i", "jj", "<ESC>", { desc = "Escape" })
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Accept Codeium" })

map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("i", "<C-Space>", function()
  require("cmp").complete()
end, { noremap = true, silent = true, desc = "Call autocompletion" })

map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Swap line down" })
map("v", "K", ":m '>-1<CR>gv=gv", { noremap = true, silent = true, desc = "Swap line up" })

map("v", "H", "<gv", { noremap = true, silent = true, desc = "Indent left" })
map("v", "L", ">gv", { noremap = true, silent = true, desc = "Indent right" })

-- Buffer
map("n", "<leader>w", "<cmd>wa<CR>", { desc = "Save" })
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close All Buffers" })

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
    end, { desc = "Previous Buffer Left (In Buffer Mode)", noremap = true, silent = true })
    map("n", "l", function()
      require("nvchad.tabufline").next()
    end, { desc = "Next Buffer Left (In Buffer Mode)", noremap = true, silent = true })
    map("n", "H", function()
      require("nvchad.tabufline").move_buf(-1)
    end, { desc = "Move Buffer Left (In Buffer Mode)", noremap = true, silent = true })
    map("n", "L", function()
      require("nvchad.tabufline").move_buf(1)
    end, { desc = "Move Buffer Right (In Buffer Mode)", noremap = true, silent = true })
    map("n", "q", toggle_buffer_mode, { desc = "Close Buffer Mode", noremap = true, silent = true })
    buffer_mode_active = true
    print "Буферный режим включен"
  end
end

map("n", "<leader>bm", toggle_buffer_mode, { desc = "Toggle Buffer Mode", noremap = true, silent = true })

-- Tmux
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", { desc = "Tmux Down" })

-- Translate
map("v", "<leader>te", ":Translate EN<CR>", { desc = "Translate (en)" })
map("v", "<leader>tr", ":Translate RU<CR>", { desc = "Translate (ru)" })
map("v", "<leader>to", ":Translate EN --output=replace<CR>", { desc = "Translate (en) with replace" })

-- Tests
map("n", "<leader>tt", function()
  neotest.run.run()
end, { desc = "Run nearest test" })
map("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand "%")
end, { desc = "Run file test" })
map("n", "<leader>to", ":Neotest output<CR>", { desc = "Show test output" })
map("n", "<leader>ts", ":Neotest summary<CR>", { desc = "Show test summary" })

-- Trouble
map("n", "<leader>qx", "<cmd>TroubleToggle<CR>", { desc = "Open Trouble" })
map("n", "<leader>qw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open Workspace Trouble" })
map("n", "<leader>qd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open Document Trouble" })
map("n", "<leader>qq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open Quickfix" })
map("n", "<leader>ql", "<cmd>TroubleToggle loclist<CR>", { desc = "Open Location List" })
map("n", "<leader>qt", "<cmd>TodoTrouble<CR>", { desc = "Open Todo Trouble" })

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git Log" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Git File History" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "Git File History" })
map("n", "<leader>go", ":DiffviewOpen<CR>", { desc = "Git Diff Open" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Git Diff Close" })

-- Debug
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle Debug UI" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>ds", function()
  require("dap").continue()
end, { desc = "Start" })
map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over" })

-- Terminal
map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, { desc = "Toogle Terminal Vertical" })
map("n", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, { desc = "Toogle Terminal Horizontal" })
map("n", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Toogle Terminal Float" })
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end, { desc = "Toogle Terminal Vertical" })
map("t", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp" }
end, { desc = "Toogle Terminal Horizontal" })
map("t", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Toogle Terminal Float" })
