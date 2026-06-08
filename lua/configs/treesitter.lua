local langs = {
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
  "prisma",
  "svelte",
  "go",
}

---@type TreesitterConfig
local options = {
  ensure_installed = langs,
  sync_install = false,
}

return options
