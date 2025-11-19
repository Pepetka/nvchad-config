local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

local lspconfig = vim.lsp

local servers = {
  "html",
  "cssls",
  "svelte",
  "lua_ls",
  "jsonls",
  "prismals",
  "tailwindcss",
  "cssmodules_ls",
  "css_variables",
}

for _, lsp in ipairs(servers) do
  lspconfig.config(lsp, {
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
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
  lspconfig.enable(lsp)
end
