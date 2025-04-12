---@type ColortilsConfig
local options = {
  mappings = {
    increment = "l",
    decrement = "h",
    increment_big = "L",
    decrement_big = "H",
    set_register_default_format = "<cr>",
    set_register_choose_format = "c<cr>",
    replace_default_format = "d<cr>",
    replace_choose_format = "r<cr>",
    export = "E",
    set_value = "c",
    transparency = "T",
    choose_background = "B",
    quit_window = { "q", "<esc>" },
  },
}

return options
