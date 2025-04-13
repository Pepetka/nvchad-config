local tools = require "utils.has_tools"

local list_by_condition = require "utils.list_by_condition"

local stylua = { stylua = true }
local prettier = { prettier = true }
local prettier_stylelint = { stylelint = tools.has_stylelint(), prettier = true }
local prettier_eslint = { eslint_d = tools.has_eslint(), prettier = true }

---@type conform.setupOpts
local options = {
  formatters_by_ft = {
    lua = list_by_condition(stylua),
    css = list_by_condition(prettier_stylelint),
    html = list_by_condition(prettier),
    json = list_by_condition(prettier),
    typescript = list_by_condition(prettier_eslint),
    javascript = list_by_condition(prettier_eslint),
    typescriptreact = list_by_condition(prettier_eslint),
    javascriptreact = list_by_condition(prettier_eslint),
  },

  format_on_save = {
    timeout_ms = 10000,
    lsp_fallback = true,
  },
}

return options
