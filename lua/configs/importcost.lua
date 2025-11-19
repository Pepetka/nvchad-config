vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufEnter" }, {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.cmd "ImportCost"
  end,
  group = vim.api.nvim_create_augroup("import_cost_auto_run", { clear = true }),
})
