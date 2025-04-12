---@type TreesitterConfig
local options = {
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "styled",
    "typescript",
    "javascript",
    "tsx",
    "query",
    "markdown",
    "markdown_inline",
    "http",
    "hurl",
  },
  sync_install = false,
}

return options
