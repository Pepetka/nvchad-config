require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "lua_ls",
  "tailwindcss",
  "cssmodules_ls",
  "css_variables",
}
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      ---@type LuaLSSettings
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            vim.fn.stdpath "data" .. "/lazy",
          },
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
        telemetry = { enable = false },
      },
      ---@type TailwindCSSSettings
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
end
