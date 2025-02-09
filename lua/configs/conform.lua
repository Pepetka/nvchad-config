local stylua = { "stylua" }
local prettier = { "prettier" }
local prettier_stylelint = { "stylelint" }
local prettier_eslint = { "eslint_d", "prettier", stop_after_first = true }

local options = {
  formatters_by_ft = {
    lua = stylua,
    css = prettier_stylelint,
    html = prettier,
    json = prettier,
    typescript = prettier_eslint,
    javascript = prettier_eslint,
    typescriptreact = prettier_eslint,
    javascriptreact = prettier_eslint,
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
