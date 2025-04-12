---@type neotest.JestOptions
local jestAdapterOpts = {
  jestCommand = "pnpm test:unit",
  jestConfigFile = "jest.config.ts",
  env = { CI = "true" },
  cwd = function(path)
    return vim.fn.getcwd()
  end,
}

---@type NeotestPlaywrightConfig
local playwrightAdapterOpts = {
  options = {
    persist_project_selection = true,
    enable_dynamic_test_discovery = true,
  },
}

require("neotest").setup {
  adapters = {
    require "neotest-jest"(jestAdapterOpts),
    require("neotest-playwright").adapter(playwrightAdapterOpts),
  },
}
