---@type { opts: nvim-ts-autotag.Opts }
local options = {
  opts = {
    enable_close_on_slash = true,
  },
}

require("nvim-ts-autotag").setup(options)
