---@meta

---@class TranslateDefaultConfig
---@field command? string
---@field parse_before? string | string[]
---@field parse_after? string | string[]
---@field output? string

---@class TranslatePresetParseBeforeNatural
---@field lang_abbr? table<string, string>
---@field end_marks? table<string, string[]>
---@field start_marks? table<string, string[]>

---@class TranslatePresetParseBeforeConcat
---@field sep? string

---@class TranslatePresetOutputInsert
---@field base? "top" | "bottom"
---@field off? integer

---@class TranslatePresetOutputSplit
---@field position? "top" | "bottom"
---@field min_size? integer
---@field max_size? number
---@field name? string
---@field filetype? string
---@field append? boolean

---@class TranslatePresetOutputFloating
---@field relative? string
---@field style? string
---@field width? number
---@field height? number
---@field row? number
---@field col? number
---@field border? string
---@field filetype? string
---@field zindex? number

---@class TranslatePresetOutputRegister
---@field name? string

---@class TranslatePresetOutput
---@field insert? TranslatePresetOutputInsert
---@field split? TranslatePresetOutputSplit
---@field floating? TranslatePresetOutputFloating
---@field replace? any
---@field register? TranslatePresetOutputRegister

---@class TranslatePresetConfig
---@field output? TranslatePresetOutput
---@field parse_before? table<string, TranslatePresetParseBeforeNatural | TranslatePresetParseBeforeConcat | nil>
---@field parse_after? table<string, table>  -- no options defined for parse_after variants
---@field command? table<string, { args?: string[] }>

---@class TranslateConfig
---@field default? TranslateDefaultConfig
---@field preset? TranslatePresetConfig
---@field command_name? string
---@field silent? boolean
---@field replace_symbols? table<string, table<string, string>>
