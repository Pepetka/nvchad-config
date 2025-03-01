local check_typescript = require "utils.compare_versions"

local styled_plugin = check_typescript "4.9.0" and {
  "@styled/typescript-styled-plugin",
} or {
  "typescript-styled-plugin",
}

local options = {
  on_attach = require("nvchad.configs.lspconfig").on_attach,
  on_init = require("nvchad.configs.lspconfig").on_init,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
  settings = {
    tsserver_plugins = styled_plugin,
  },
}

return options
