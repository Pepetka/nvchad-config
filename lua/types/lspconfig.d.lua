--@meta

-- Lua Language Server (lua_ls) settings
---@class LuaLSSettingsRuntime
---@field version? string
---@field path? string[]

---@class LuaLSSettingsDiagnostics
---@field enable? boolean
---@field globals? string[]
---@field disable? string[]
---@field severity? table<string, 'Hint' | 'Info' | 'Warning' | 'Error'>

---@class LuaLSSettingsWorkspace
---@field checkThirdParty? boolean | 'Disable'
---@field library? string[]
---@field maxPreload? number
---@field preloadFileSize? number
---@field ignoreDir? string[]
---@field useGitIgnore? boolean

---@class LuaLSSettingsCompletion
---@field enable? boolean
---@field callSnippet? 'Disable' | 'Replace' | 'Both'
---@field keywordSnippet? 'Disable' | 'Replace' | 'Both'
---@field workspaceWord? boolean
---@field showWord? 'Enable' | 'Fallback' | 'Disable'

---@class LuaLSSettingsHint
---@field enable? boolean
---@field setType? boolean
---@field paramType? boolean
---@field paramName? 'All' | 'Literal' | 'Disable'

---@class LuaLSSettingsFormat
---@field enable? boolean
---@field defaultConfig? table<string, string>

---@class LuaLSSettingsType
---@field castNumberToInteger? boolean

---@class LuaLSSettingsTelemetry
---@field enable? boolean

---@class LuaLSSettings
---@field runtime? LuaLSSettingsRuntime
---@field diagnostics? LuaLSSettingsDiagnostics
---@field workspace? LuaLSSettingsWorkspace
---@field completion? LuaLSSettingsCompletion
---@field hint? LuaLSSettingsHint
---@field telemetry? LuaLSSettingsTelemetry
---@field format? LuaLSSettingsFormat
---@field type? LuaLSSettingsType

-- Tailwind CSS Language Server settings
---@class TailwindCSSExperimentalSettings
---@field classRegex? (string | [string, string])[]

---@class TailwindCSSSettings
---@field classAttributes? string[]
---@field cssLanguages? string[]
---@field htmlLanguages? string[]
---@field javascriptLanguages? string[]
---@field markdownLanguages? string[]
---@field experimental? TailwindCSSExperimentalSettings
---@field validate? boolean
---@field lint? table<string, 'warning' | 'error'>
---@field emmetCompletions? boolean

-- TypeScript Tools (pmizio/typescript-tools.nvim)
---@class TSToolsJSXCloseTag
---@field enable? boolean
---@field filetypes? string[]

---@class TSToolsImportAllPriorities
---@field same_file? number
---@field local? number
---@field buffer? number
---@field buffers? number
---@field content? number

---@class TSToolsCodeLensConfig
---@field references? boolean
---@field implementations? boolean

---@class TypeScriptToolsSettings
---@field tsserver_path? string
---@field tsserver_plugins? string[]
---@field tsserver_max_memory? number
---@field tsserver_format_options? table<string, any>
---@field tsserver_file_preferences? table<string, any>
---@field tsserver_locale? string
---@field complete_function_calls? boolean
---@field include_completions_with_insert_text? boolean
---@field jsx_close_tag? TSToolsJSXCloseTag
---@field expose_as_code_action? string[]
---@field code_lens? string[] | TSToolsCodeLensConfig
---@field disable_member_code_lens? boolean
---@field separate_diagnostic_server? boolean
---@field publish_diagnostic_on? 'insert_leave' | 'change'
---@field enable_import_on_completion? boolean
---@field import_all_timeout? number
---@field import_all_priorities? TSToolsImportAllPriorities
---@field import_all_scan_buffers? boolean
---@field import_all_select_source? boolean
