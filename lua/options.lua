require "nvchad.options"

local o = vim.o
local g = vim.g

o.shell = "zsh"
g.codeium_no_map_tab = true

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
