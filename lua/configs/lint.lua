-- local function has_eslint()
--   return vim.fn.filereadable ".eslintrc.json" == 1
-- end

-- local eslint = has_eslint() and { "eslint" } or {}
local eslint = { "eslint_d" }
local stylelint = { "stylelint" }

require("lint").linters_by_ft = {
  css = stylelint,
  javascript = eslint,
  typescript = eslint,
  typescriptreact = eslint,
  javascriptreact = eslint,
}

vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
