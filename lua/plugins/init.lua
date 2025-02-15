return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "stylelint",
        "eslint-lsp",
        "eslint_d",
        "lua-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
        "cssmodules-language-server",
        "css-variables-language-server",
        "html-lsp",
        "css-lsp",
      },
      automatic_installation = true,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "tsx",
        "markdown",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
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
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require "configs.test"
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  {
    "uga-rosa/translate.nvim",
    event = "BufRead",
    opts = require "configs.translate",
  },
  {
    "rcarriga/nvim-notify",
    opts = require "configs.notify",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require "configs.noice",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    opts = {},
  },
  {
    "max397574/colortils.nvim",
    event = "BufRead",
    cmd = "Colortils",
    opts = {},
  },
  {
    "rbong/vim-flog",
    lazy = true,
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {},
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
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
}
