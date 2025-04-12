---@meta

-- neotest-playwright
---@class NeotestPlaywrightExperimentalTelescope
---@field enabled? boolean
---@field opts? table

---@class NeotestPlaywrightExperimental
---@field telescope? NeotestPlaywrightExperimentalTelescope

---@class NeotestPlaywrightOptions
---@field persist_project_selection? boolean
---@field enable_dynamic_test_discovery? boolean
---@field preset? "none" | "headed" | "debug"
---@field get_playwright_binary? fun(): string
---@field get_playwright_config? fun(): string
---@field get_cwd? fun(): string
---@field env? table<string, string>
---@field extra_args? string[]
---@field filter_dir? fun(name: string, rel_path: string, root: string): boolean
---@field is_test_file? fun(file_path: string): boolean
---@field experimental? NeotestPlaywrightExperimental

---@class NeotestPlaywrightConfig
---@field options? NeotestPlaywrightOptions
