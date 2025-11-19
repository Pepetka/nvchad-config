-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",
  theme_toggle = { "doomchad", "zenburn" },
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  DiffChange = {
    bg = "#464414",
    fg = "none",
  },
  DiffAdd = {
    bg = "#103507",
    fg = "none",
  },
  DiffRemoved = {
    bg = "#461414",
    fg = "none",
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    modules = {},
  },
  tabufline = {
    lazyload = false,
    order = { "buffers", "tabs", "treeOffset" },
  },
  cmp = {
    format_colors = {
      tailwind = true,
    },
    style = "atom",
  },
}

M.cheatsheet = {
  theme = "simple",
}

M.mason = {
  pkgs = {
    "stylua",
    "css-lsp",
    "html-lsp",
    "json-lsp",
    "eslint_d",
    "prettier",
    "stylelint",
    "lua-language-server",
    "svelte-language-server",
    "prisma-language-server",
    "cssmodules-language-server",
    "tailwindcss-language-server",
    "css-variables-language-server",
  },
}

M.colorify = {
  enabled = true,
  mode = "bg",
}

M.nvdash = {
  load_on_startup = true,
  -- header = {
  --   " ▄████▄        ▒█████        ██▀███       ▓█████ ",
  --   "▒██▀ ▀█       ▒██▒  ██▒     ▓██ ▒ ██▒     ▓█   ▀ ",
  --   "▒▓█    ▄      ▒██░  ██▒     ▓██ ░▄█ ▒     ▒███   ",
  --   "▒▓▓▄ ▄██▒     ▒██   ██░     ▒██▀▀█▄       ▒▓█  ▄ ",
  --   "▒ ▓███▀ ░ ██▓ ░ ████▓▒░ ██▓ ░██▓ ▒██▒ ██▓ ░▒████▒",
  --   "░ ░▒ ▒  ░ ▒▓▒ ░ ▒░▒░▒░  ▒▓▒ ░ ▒▓ ░▒▓░ ▒▓▒ ░░ ▒░ ░",
  --   "  ░  ▒    ░▒    ░ ▒ ▒░  ░▒    ░▒ ░ ▒░ ░▒   ░ ░  ░",
  --   "░         ░   ░ ░ ░ ▒   ░     ░░   ░  ░      ░   ",
  --   "░ ░        ░      ░ ░    ░     ░       ░     ░  ░",
  --   "░          ░             ░             ░         ",
  --   "                                                 ",
  --   "╭┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╮",
  --   "         Code. Organize. Refine. Execute         ",
  --   "╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╯",
  --   "                                                 ",
  -- },
  header = {
    " ██████╗    ██████╗    ██████╗    ███████╗",
    "██╔════╝   ██╔═══██╗   ██╔══██╗   ██╔════╝",
    "██║        ██║   ██║   ██████╔╝   █████╗  ",
    "██║        ██║   ██║   ██╔══██╗   ██╔══╝  ",
    "╚██████╗██╗╚██████╔╝██╗██║  ██║██╗███████╗",
    " ╚═════╝╚═╝ ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝╚══════╝",
    "                                          ",
    "╭┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╮",
    "     Code. Organize. Refine. Execute.     ",
    "╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈╯",
    "                                          ",
  },
}

return M
