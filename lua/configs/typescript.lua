local check_typescript = require "utils.compare_versions"
local nvlsp = require "nvchad.configs.lspconfig"

local styled_plugin = check_typescript "4.9.0"
    and {
      "@styled/typescript-styled-plugin",
      "typescript-svelte-plugin",
    }
  or {
    "typescript-styled-plugin",
    "typescript-svelte-plugin",
  }

local options = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  ---@type TypeScriptToolsSettings
  settings = {
    tsserver_plugins = styled_plugin,
  },
}

return options
