---@meta

---@class ScrollbarMark
---@field text? string|string[]
---@field priority? integer
---@field gui? string|string[]
---@field color? string
---@field cterm? string|string[]
---@field color_nr? integer
---@field highlight? string

---@class ScrollbarMarksConfig
---@field Cursor? ScrollbarMark
---@field Search? ScrollbarMark
---@field Error? ScrollbarMark
---@field Warn? ScrollbarMark
---@field Info? ScrollbarMark
---@field Hint? ScrollbarMark
---@field Misc? ScrollbarMark
---@field GitAdd? ScrollbarMark
---@field GitChange? ScrollbarMark
---@field GitDelete? ScrollbarMark

---@class ScrollbarHandleConfig
---@field text? string
---@field blend? integer
---@field color? string
---@field color_nr? integer
---@field highlight? string
---@field hide_if_all_visible? boolean

---@class ScrollbarAutocmdConfig
---@field render? string[]
---@field clear? string[]

---@class ScrollbarHandlersConfig
---@field cursor? boolean
---@field diagnostic? boolean
---@field gitsigns? boolean
---@field handle? boolean
---@field search? boolean
---@field ale? boolean

---@class ScrollbarConfig
---@field show? boolean
---@field show_in_active_only? boolean
---@field set_highlights? boolean
---@field folds? integer
---@field max_lines? integer|false
---@field hide_if_all_visible? boolean
---@field throttle_ms? integer
---@field handle? ScrollbarHandleConfig
---@field marks? ScrollbarMarksConfig
---@field excluded_buftypes? string[]
---@field excluded_filetypes? string[]
---@field autocmd? ScrollbarAutocmdConfig
---@field handlers? ScrollbarHandlersConfig
