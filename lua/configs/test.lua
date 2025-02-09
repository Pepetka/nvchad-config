require("neotest").setup {
  adapters = {
    require "neotest-jest" {
      jestCommand = "pnpm test:unit",
      jestConfigFile = "jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    },
  },
}
