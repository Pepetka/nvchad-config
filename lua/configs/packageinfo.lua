local pi = require "package-info"

pi.setup()

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*.json", "*.jsonc" },
  callback = function()
    vim.cmd "PackageInfoShow"
  end,
  group = vim.api.nvim_create_augroup("package_info_auto_run", { clear = true }),
})
