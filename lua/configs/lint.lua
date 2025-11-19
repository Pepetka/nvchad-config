local tools = require "utils.has_tools"
local list_by_condition = require "utils.list_by_condition"

local eslint = { eslint_d = tools.has_eslint() }
local stylelint = { stylelint = tools.has_stylelint() }

require("lint").linters_by_ft = {
  css = list_by_condition(stylelint),
  javascript = list_by_condition(eslint),
  typescript = list_by_condition(eslint),
  typescriptreact = list_by_condition(eslint),
  javascriptreact = list_by_condition(eslint),
}

vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave", "TextChanged", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
