require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "css_variables",
}
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          "tw\\(([^)]*)\\)",
          "[a-zA-Z]*[cC]lass[Nn]ame[s]?[a-zA-Z]*\\s*=\\s*[{]?[\"']?([^\"'{}]*)[\"']?[}]?",
          "[\"']?([a-zA-Z]*[cC]lass[Nn]ame[s]?)[\"']?\\s*:\\s*['\"]([^'\"]*)['\"]",
        },
      },
    },
  },
}
