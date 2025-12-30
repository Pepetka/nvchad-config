local merge_tables = require "utils.merge_tables"

local colors = {
  bg = "#181926",
  fg = "#cad3f5",
  yellow = "#eed49f",
  cyan = "#91d7e3",
  darkblue = "#494926",
  green = "#a6da95",
  orange = "#f5a97f",
  violet = "#b7bdf8",
  magenta = "#f5bde6",
  blue = "#8aadf4",
  red = "#ed8796",
  transparent = "none",
}

local function get_mode_color()
  local mode_color = {
    n = colors.violet,
    i = colors.green,
    v = colors.yellow,
    [""] = colors.blue,
    V = colors.yellow,
    c = colors.magenta,
    no = colors.orange,
    s = colors.orange,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.yellow,
    R = colors.orange,
    Rv = colors.orange,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.cyan,
    t = colors.blue,
  }
  return mode_color[vim.fn.mode()]
end

local function get_opposite_color(mode_color)
  local opposite_colors = {
    [colors.red] = colors.bg,
    [colors.blue] = colors.darkblue,
    [colors.green] = colors.darkblue,
    [colors.magenta] = colors.darkblue,
    [colors.orange] = colors.darkblue,
    [colors.cyan] = colors.darkblue,
    [colors.violet] = colors.darkblue,
    [colors.yellow] = colors.darkblue,
    [colors.darkblue] = colors.fg,
  }
  return opposite_colors[mode_color] or colors.FG
end

local options = {
  options = {
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.transparent } },
      inactive = { c = { fg = colors.fg, bg = colors.transparent } },
    },
    component_separators = "",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

local conditions = {
  buffer_editable = function()
    return vim.bo.buftype == ""
  end,
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  check_lsp = function()
    local buf_clients = vim.lsp.get_clients { bufnr = 0 }
    return next(buf_clients) ~= nil
  end,
  combine_checks = function(condFn1, condFn2)
    return function()
      return condFn1() and condFn2()
    end
  end,
}

local function ins_left(component)
  table.insert(options.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(options.sections.lualine_x, component)
end

---@param right? boolean
local function spase(right)
  local ins = right and ins_right or ins_left
  ins {
    function()
      return " "
    end,
    draw_empty = true,
    padding = -2,
  }
end

---@class ColorTable
---@field fg? string
---@field bg? string

---@class Space
---@field left? boolean
---@field right? boolean

---@class IconBlock
---@field color ColorTable | function(): ColorTable
---@field icon function(): string

---@param component table
---@param icon_block IconBlock
---@param space? Space
local function ins_left_capsule(component, icon_block, space)
  if space and space.left then
    spase()
  end
  ins_left(merge_tables({
    separator = { left = "" },
    icons_enabled = false,
    padding = { left = 0, right = 1 },
  }, component))
  ins_left {
    cond = component.cond,
    function()
      return icon_block.icon()
    end,
    draw_empty = true,
    color = icon_block.color,
    separator = { right = "" },
    padding = { left = 1, right = 0 },
  }
  if space and space.right then
    spase()
  end
end

---@param component table
---@param icon_block IconBlock
---@param space? Space
local function ins_right_capsule(component, icon_block, space)
  if space and space.left then
    spase(true)
  end
  ins_right {
    cond = component.cond,
    function()
      return icon_block.icon()
    end,
    draw_empty = true,
    color = icon_block.color,
    separator = { left = "" },
    -- padding = { left = 1, right = 2 },
  }
  ins_right(merge_tables({
    separator = { right = "" },
    icons_enabled = false,
  }, component))
  if space and space.right then
    spase(true)
  end
end

ins_left {
  "mode",
  color = function()
    local mode_color = get_mode_color()
    return { fg = get_opposite_color(mode_color), bg = mode_color, gui = "bold" }
  end,
  separator = { right = "" },
  padding = { left = 1, right = 0 },
}

ins_left_capsule({
  "branch",
  cond = conditions.check_git_workspace,
  color = { fg = colors.magenta, bg = colors.darkblue, gui = "bold" },
  separator = { left = "" },
  icons_enabled = false,
}, {
  icon = function()
    return ""
  end,
  color = { fg = colors.darkblue, bg = colors.magenta },
}, { left = true })

ins_left_capsule({
  "filename",
  path = 0,
  cond = conditions.combine_checks(conditions.buffer_not_empty, conditions.buffer_editable),
  color = function()
    return vim.bo.modified and { fg = colors.orange, bg = colors.darkblue }
      or { fg = colors.green, bg = colors.darkblue }
  end,
  separator = { left = "" },
  file_status = false,
}, {
  icon = function()
    return ""
  end,
  color = function()
    return vim.bo.modified and { fg = colors.darkblue, bg = colors.orange }
      or { fg = colors.darkblue, bg = colors.green }
  end,
}, {
  left = true,
})

---

ins_right {
  cond = conditions.check_lsp,
  "lsp_status",
  show_name = false,
  icons_enabled = false,
}

ins_right {
  cond = conditions.combine_checks(conditions.check_lsp, conditions.hide_in_width),
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })

    local clients = vim.lsp.get_clients { bufnr = 0 }
    if next(clients) == nil then
      return msg
    end

    local preferred = {
      "svelte-language-server",
      "typescript-tools",
    }

    local function supports_buf(client)
      local filetypes = client.config and client.config.filetypes
      return filetypes and vim.tbl_contains(filetypes, buf_ft)
    end

    local function is_preferred(client)
      return vim.tbl_contains(preferred, client.name)
    end

    for _, client in ipairs(clients) do
      if supports_buf(client) and is_preferred(client) then
        return client.name
      end
    end

    for _, client in ipairs(clients) do
      if supports_buf(client) then
        return client.name
      end
    end

    return msg
  end,
  color = { fg = colors.fg, gui = "bold" },
}
spase(true)

ins_right {
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  cond = conditions.hide_in_width,
  separator = { left = "", right = "" },
  color = { fg = colors.fg, bg = colors.darkblue },
  diff_color = {
    added = { fg = colors.green, bg = colors.darkblue },
    modified = { fg = colors.orange, bg = colors.darkblue },
    removed = { fg = colors.red, bg = colors.darkblue },
  },
  padding = { left = 0, right = 0 },
}

ins_right {
  "diagnostics",
}

spase(true)
ins_right {
  "filetype",
  cond = conditions.combine_checks(conditions.buffer_not_empty, conditions.buffer_editable),
  color = { fg = colors.darkblue, bg = colors.magenta },
  colored = false,
  icon_only = true,
  separator = { left = "" },
  padding = { left = 0, right = 0 },
}
ins_right {
  "filetype",
  cond = conditions.combine_checks(conditions.buffer_not_empty, conditions.buffer_editable),
  color = { fg = colors.magenta, bg = colors.darkblue },
  icons_enabled = false,
  separator = { right = "" },
  padding = { left = 1, right = 0 },
}
spase(true)

ins_right {
  "location",
  color = { fg = colors.darkblue, bg = colors.violet, gui = "bold" },
  separator = { left = "", color = { fg = colors.violet, bg = colors.violet } },
  padding = { left = 0, right = 1 },
}

return options
