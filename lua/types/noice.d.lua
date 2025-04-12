---@meta

---@class NoiceLspOverrideConfig
---@field [string] boolean

---@class NoiceLspHoverConfig
---@field enabled? boolean
---@field silent? boolean
---@field view? string
---@field opts? table

---@class NoiceLspSignatureAutoOpen
---@field enabled? boolean
---@field trigger? boolean
---@field luasnip? boolean
---@field throttle? number

---@class NoiceLspSignatureConfig
---@field enabled? boolean
---@field auto_open? NoiceLspSignatureAutoOpen
---@field view? string
---@field opts? table

---@class NoiceLspMessageConfig
---@field enabled? boolean
---@field view? string
---@field opts? table

---@class NoiceLspDocumentationConfig
---@field view? string
---@field opts? table

---@class NoiceLspProgressConfig
---@field enabled? boolean
---@field format? string
---@field format_done? string
---@field throttle? number
---@field view? string

---@class NoiceLspConfig
---@field progress? NoiceLspProgressConfig
---@field override? NoiceLspOverrideConfig
---@field hover? NoiceLspHoverConfig
---@field signature? NoiceLspSignatureConfig
---@field message? NoiceLspMessageConfig
---@field documentation? NoiceLspDocumentationConfig

---@class NoiceCmdlineFormat
---@field pattern? string|string[]
---@field icon? string
---@field lang? string
---@field view? string
---@field opts? table
---@field conceal? boolean
---@field icon_hl_group? string
---@field title? string

---@class NoiceCmdlineConfig
---@field enabled? boolean
---@field view? string
---@field opts? table
---@field format? table<string, NoiceCmdlineFormat|false>

---@class NoiceMessagesConfig
---@field enabled? boolean
---@field view? string
---@field view_error? string
---@field view_warn? string
---@field view_history? string
---@field view_search? string|false

---@class NoicePopupmenuConfig
---@field enabled? boolean
---@field backend? 'nui'|'cmp'
---@field kind_icons? table|string[]|false

---@class NoiceNotifyConfig
---@field enabled? boolean
---@field view? string

---@class NoicePresetsConfig
---@field bottom_search? boolean
---@field command_palette? boolean
---@field long_message_to_split? boolean
---@field inc_rename? boolean
---@field lsp_doc_border? boolean

---@class NoiceRedirectConfig
---@field view? string
---@field filter? table

---@class NoiceCommandConfig
---@field view? string
---@field opts? table
---@field filter? table
---@field filter_opts? table

---@class NoiceConfigOpts
---@field cmdline? NoiceCmdlineConfig
---@field messages? NoiceMessagesConfig
---@field popupmenu? NoicePopupmenuConfig
---@field notify? NoiceNotifyConfig
---@field lsp? NoiceLspConfig
---@field presets? NoicePresetsConfig
---@field redirect? NoiceRedirectConfig
---@field commands? table<string, NoiceCommandConfig>
---@field markdown? table
---@field health? { checker?: boolean }
---@field throttle? number
---@field views? table<string, table>
---@field routes? table[]
---@field status? table<string, table>
---@field format? table
