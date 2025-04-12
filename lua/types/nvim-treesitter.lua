-- Treesitter
---@class TreesitterSelectionKeymaps
---@field init_selection? string
---@field node_incremental? string
---@field node_decremental? string
---@field scope_incremental? string

---@class TreesitterIncrementalSelection
---@field enable boolean
---@field keymaps? TreesitterSelectionKeymaps

---@class TreesitterHighlight
---@field enable boolean
---@field disable? string[]

---@class TreesitterIndent
---@field enable boolean
---@field disable? string[]

---@class TreesitterConfig
---@field ensure_installed string[] | 'all'
---@field sync_install? boolean
---@field auto_install? boolean
---@field ignore_install? string[]
---@field highlight? TreesitterHighlight
---@field indent? TreesitterIndent
---@field incremental_selection? TreesitterIncrementalSelection
---@field textobjects? table
