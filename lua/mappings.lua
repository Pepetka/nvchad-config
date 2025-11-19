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
map("n", ";", ":", opts("Basic: CMD enter command mode", { silent = false }))

map("i", "jk", "<ESC>", opts "Basic: Escape")
map("i", "jj", "<ESC>", opts "Basic: Escape")

map("i", "<C-Space>", function()
  require("cmp").complete()
end, opts "Basic: Call Autocomplete")

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true, timeout_ms = 10000 }
  require("lint").try_lint()
end, opts "Basic: Format Code")

map("v", "D", ":m '>+1<CR>gv=gv", opts "Basic: Swap line down")
map("v", "U", ":m '>-1<cr>gv=gv", opts "Basic: swap line up")

map("v", "H", "<gv", opts "Basic: Indent left")
map("v", "L", ">gv", opts "Basic: Indent right")

-- NeoCodeium
map("i", "<M-g>", function()
  require("neocodeium").accept()
end, opts("Codeium: Accept Codeium", { expr = true }))
map("i", "<M-w>", function()
  require("neocodeium").accept_word()
end, opts("Codeium: Accept Codeium", { expr = true }))
map("i", "<M-l>", function()
  require("neocodeium").accept_line()
end, opts("Codeium: Accept Codeium", { expr = true }))
map("i", "<M-j>", function()
  require("neocodeium").cycle_or_complete()
end, opts("Codeium: Cycle Completions", { expr = true }))
map("i", "<M-k>", function()
  require("neocodeium").cycle_or_complete(-1)
end, opts("Codeium: Cycle Completions", { expr = true }))
map("i", "<M-x>", function()
  require("neocodeium").clear()
end, opts("Codeium: Clear", { expr = true }))

-- Buffer
map("n", "<leader>w", "<cmd>wa<CR>", opts "Buffer: Save All")
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, opts "Buffer: Close all buffers")

local buffer_mode_active = false
local function toggle_buffer_mode()
  if buffer_mode_active then
    del("n", "h")
    del("n", "l")
    del("n", "H")
    del("n", "L")
    del("n", "x")
    del("n", "q")
    buffer_mode_active = false
    print "Buffer mode disabled"
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
    map("n", "x", function()
      require("nvchad.tabufline").close_buffer()
    end, opts "Buffer Mode: Close Buffer")
    map("n", "q", toggle_buffer_mode, opts "Buffer Mode: Close Buffer Mode")
    buffer_mode_active = true
    print "Buffer mode enabled"
  end
end

map("n", "<leader>bm", toggle_buffer_mode, opts "Buffer: Toggle Buffer Mode")

-- Tmux
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", opts "Tmux: Tmux Right")
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", opts "Tmux: Tmux Left")
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", opts "Tmux: Tmux Up")
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", opts "Tmux: Tmux Down")

-- Translate
map("v", "<leader>te", ":Translate EN<CR>", opts "Translate: Translate (en)")
map("v", "<leader>tr", ":Translate RU<CR>", opts "Translate: Translate (ru)")
map("v", "<leader>toe", ":Translate EN --output=replace<CR>", opts "Translate: Translate (en) and replace")
map("v", "<leader>tor", ":Translate Ru --output=replace<CR>", opts "Translate: Translate (ru) and replace")

-- Tests
map("n", "<leader>tt", function()
  neotest.run.run()
end, opts "Test: Run nearest test")
map("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand "%")
end, opts "Test: Run test file")
map("n", "<leader>to", ":Neotest output<CR>", opts "Test: Show test output")
map("n", "<leader>ts", ":Neotest summary<CR>", opts "Test: Show test summary")

-- Trouble
map("n", "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", opts "Trouble: Open Workspace Trouble")
map("n", "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts "Trouble: Open Document Trouble")
map("n", "<leader>qq", "<cmd>Trouble qflist toggle<cr>", opts "Trouble: Open Quickfix")
map("n", "<leader>qt", "<cmd>TodoQuickFix<CR>", opts "Trouble: Open Todo Trouble")

-- Todo
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", opts "Todo: Telescope Todo")

-- Git
map("n", "<leader>gl", ":Flog<CR>", opts "Git: Git Log")
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", opts "Git: Git File History")
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", opts "Git: Git Diff Toggle File")
map("n", "<leader>go", ":DiffviewOpen<CR>", opts "Git: Git Diff Open")
map("n", "<leader>gc", ":DiffviewClose<CR>", opts "Git: Git Diff Close")
map("n", "<leader>gb", ":Gitsigns blame<CR>", opts "Git: Git Blame")
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts "Git: Git Preview Hunk")
map("n", "<leader>gbt", ":Gitsigns toggle_current_line_blame<CR>", opts "Git: Git Toggle Current Line Blame")

-- Debug
map("n", "<leader>du", function()
  require("dapui").toggle()
end, opts "Debug: Toggle Debug UI")
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, opts "Debug: Toggle Breakpoint")
map("n", "<leader>ds", function()
  require("dap").continue()
end, opts "Debug: Debug Start")
map("n", "<leader>dO", function()
  require("dap").step_out()
end, opts "Debug: Debug Step Out")
map("n", "<leader>do", function()
  require("dap").step_over()
end, opts "Debug: Debug Step Over")

-- Terminal
map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, opts "Terminal: Toogle Terminal Vertical")
map("n", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, opts "Terminal: Toogle Terminal Horizontal")
map("n", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, opts "Terminal: Toogle Terminal Float")
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end, opts "Terminal: Toogle Terminal Vertical")
map("t", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp" }
end, opts "Terminal: Toogle Terminal Horizontal")
map("t", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, opts "Terminal: Toogle Terminal Float")

-- LLM
map({ "n", "v" }, "<leader>ll", ":Gen<CR>", opts "LLM: Prompts List")
map({ "n", "v" }, "<leader>lc", ":ChatGPT<CR>", opts "LLM: Open Chat")

-- Markdown
map("n", "<leader>md", ":MarkdownPreviewToggle<CR>", opts "Markdown: Markdown Preview")

-- Package-info
map("n", "<leader>ns", function()
  require("package-info").show()
end, opts "Package-info: Show dependency versions")
map("n", "<leader>nc", function()
  require("package-info").hide()
end, opts "Package-info: Hide dependency versions")
map("n", "<leader>nt", function()
  require("package-info").toggle()
end, opts "Package-info: Toggle dependency versions")
map("n", "<leader>na", function()
  require("package-info").update_all()
end, opts "Package-info: Update all dependencies")
map("n", "<leader>nd", function()
  require("package-info").delete()
end, opts "Package-info: Delete dependency")
map("n", "<leader>ni", function()
  require("package-info").install()
end, opts "Package-info: Install new dependency")
map("n", "<leader>nf", function()
  require("package-info").update()
end, opts "Package-info: Update dependency")

--leap
map({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", opts "Leap: Leap Forward")
map({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", opts "Leap: Leap Backward")
map("n", "gs", "<Plug>(leap-from-window)", opts "Leap: Leap From Window")
