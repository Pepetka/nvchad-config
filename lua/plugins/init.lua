return {
  { import = "nvchad.blink.lazyspec" },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
    opts = require "configs.nvimtree",
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "pmizio/typescript-tools.nvim" },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = require "configs.typescript",
    build = "npm install -g @styled/typescript-styled-plugin typescript-styled-plugin typescript-svelte-plugin",
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require "configs.snacks",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = require "configs.treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPost",
    ft = {
      "html",
      "javascript",
      "typescript",
      "tsx",
    },
    config = function()
      require "configs.autotag"
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    event = "BufReadPost",
    config = function()
      require "configs.test"
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "thenbe/neotest-playwright",
    },
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "uga-rosa/translate.nvim",
    cmd = "Translate",
    opts = require "configs.translate",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require "configs.noice",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = require "configs.scrollbar",
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup()
          require("scrollbar.handlers.gitsigns").setup()
        end,
      },
      {
        "kevinhwang91/nvim-hlslens",
        config = function()
          require("scrollbar.handlers.search").setup {
            override_lens = function() end,
          }
        end,
      },
    },
  },
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    opts = require "configs.colortils",
  },
  {
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    opts = {},
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "monkoose/neocodeium",
    event = "InsertEnter",
    config = function()
      require("neocodeium").setup {
        silent = true,
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint", "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut" },
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = true },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = true,
      },
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps --no-save && npx gulp dapDebugServer && rm -rf out && mv dist out",
      },
      {
        "microsoft/vscode-chrome-debug",
        build = "npm install --no-save && npm run build",
      },
    },
    config = function()
      require "configs.debug"
    end,
  },
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    ft = "hurl",
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    opts = require "configs.gen",
    dependencies = { "MeanderingProgrammer/render-markdown.nvim" },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = require "configs.chatgpt",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },
  {
    "kndndrj/nvim-dbee",
    cmd = "Dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup {}
    end,
  },
  {
    "vuki656/package-info.nvim",
    ft = { "json", "jsonc" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require "configs.packageinfo"
    end,
  },
  {
    "yardnsm/vim-import-cost",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    config = function()
      require "configs.importcost"
    end,
    build = "npm install --production",
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = require "configs.lualine",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    event = "VeryLazy",
    opts = require "configs.telescope",
  },
}
