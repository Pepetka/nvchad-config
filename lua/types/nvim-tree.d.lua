---@meta

---@class NvimTreeSortNode
---@field absolute_path string
---@field executable boolean
---@field extension string
---@field filetype string
---@field link_to string
---@field name string
---@field type "directory" | "file" | "link"

---@alias NvimTreeSorter string | fun(nodes: NvimTreeSortNode[])

---@class NvimTreeSortConfig
---@field sorter? NvimTreeSorter
---@field folders_first? boolean
---@field files_first? boolean

---@alias NvimTreeDynamicNumber string | number | fun(): string | number

---@class NvimTreeViewWidth
---@field min? NvimTreeDynamicNumber
---@field max? NvimTreeDynamicNumber
---@field padding? number | fun(): string | number

---@class NvimTreeViewFloatConfig
---@field enable? boolean
---@field quit_on_focus_loss? boolean
---@field open_win_config? table | fun(): table

---@class NvimTreeViewConfig
---@field width? number | string | NvimTreeViewWidth | fun(): number | string
---@field side? "left" | "right"
---@field preserve_window_proportions? boolean
---@field number? boolean
---@field relativenumber? boolean
---@field signcolumn? "yes" | "auto" | "no"
---@field centralize_selection? boolean
---@field cursorline? boolean
---@field debounce_delay? number
---@field float? NvimTreeViewFloatConfig

---@class NvimTreeRendererIconsGlyphs
---@field default? string
---@field symlink? string
---@field bookmark? string
---@field modified? string
---@field hidden? string
---@field folder? table
---@field git? table

---@class NvimTreeRendererIconsConfig
---@field web_devicons? { file?: { enable?: boolean, color?: boolean }, folder?: { enable?: boolean, color?: boolean } }
---@field git_placement? "before" | "after" | "signcolumn" | "right_align"
---@field modified_placement? "before" | "after" | "signcolumn" | "right_align"
---@field hidden_placement? "before" | "after" | "signcolumn" | "right_align"
---@field diagnostics_placement? "before" | "after" | "signcolumn" | "right_align"
---@field bookmarks_placement? "before" | "after" | "signcolumn" | "right_align"
---@field padding? string
---@field symlink_arrow? string
---@field show? table
---@field glyphs? NvimTreeRendererIconsGlyphs

---@class NvimTreeRendererIndentMarkersIcons
---@field corner? string
---@field edge? string
---@field item? string
---@field bottom? string
---@field none? string

---@class NvimTreeRendererIndentMarkers
---@field enable? boolean
---@field inline_arrows? boolean
---@field icons? NvimTreeRendererIndentMarkersIcons

---@class NvimTreeRendererConfig
---@field add_trailing? boolean
---@field group_empty? boolean | fun(relative_path: string): string
---@field full_name? boolean
---@field root_folder_label? string | boolean | fun(root_cwd: string): string
---@field indent_width? number
---@field special_files? string[]
---@field hidden_display? string | fun(hidden_stats: table): string | nil
---@field symlink_destination? boolean
---@field decorators? string[]
---@field highlight_git? string | boolean
---@field highlight_diagnostics? string
---@field highlight_opened_files? string
---@field highlight_modified? string
---@field highlight_hidden? string
---@field highlight_bookmarks? string
---@field highlight_clipboard? string
---@field indent_markers? NvimTreeRendererIndentMarkers
---@field icons? NvimTreeRendererIconsConfig

---@class NvimTreeGitConfig
---@field enable? boolean
---@field ignore? boolean
---@field show_on_dirs? boolean
---@field show_on_open_dirs? boolean
---@field disable_for_dirs? string[] | fun(path: string): boolean
---@field timeout? number
---@field cygwin_support? boolean

---@class NvimTreeDiagnosticsIcons
---@field hint? string
---@field info? string
---@field warning? string
---@field error? string

---@class NvimTreeDiagnosticsSeverity
---@field min? number
---@field max? number

---@class NvimTreeDiagnosticsConfig
---@field enable? boolean
---@field show_on_dirs? boolean
---@field show_on_open_dirs? boolean
---@field debounce_delay? number
---@field severity? NvimTreeDiagnosticsSeverity
---@field icons? NvimTreeDiagnosticsIcons

---@class NvimTreeModifiedConfig
---@field enable? boolean
---@field show_on_dirs? boolean
---@field show_on_open_dirs? boolean

---@class NvimTreeFiltersConfig
---@field enable? boolean
---@field git_ignored? boolean
---@field dotfiles? boolean
---@field git_clean? boolean
---@field no_buffer? boolean
---@field no_bookmark? boolean
---@field custom? string[] | fun(absolute_path: string): boolean
---@field exclude? string[]

---@class NvimTreeLiveFilterConfig
---@field prefix? string
---@field always_show_folders? boolean

---@class NvimTreeFilesystemWatchers
---@field enable? boolean
---@field debounce_delay? number
---@field ignore_dirs? string[] | fun(path: string): boolean

---@class NvimTreeActionsOpenFileWindowPicker
---@field enable? boolean
---@field picker? "default" | fun(): integer | nil
---@field chars? string
---@field exclude? { filetype?: string[], buftype?: string[] }

---@class NvimTreeActionsOpenFile
---@field quit_on_open? boolean
---@field eject? boolean
---@field resize_window? boolean
---@field window_picker? NvimTreeActionsOpenFileWindowPicker

---@class NvimTreeExperimentalOpenFile
---@field relative_path? boolean

---@class NvimTreeActionsChangeDir
---@field enable? boolean
---@field global? boolean
---@field restrict_above_cwd? boolean

---@class NvimTreeActionsExpandAll
---@field max_folder_discovery? number
---@field exclude? string[]

---@class NvimTreeActionsFilePopup
---@field open_win_config? table

---@class NvimTreeActionsRemoveFile
---@field close_window? boolean

---@class NvimTreeActionsConfig
---@field use_system_clipboard? boolean
---@field change_dir? NvimTreeActionsChangeDir
---@field expand_all? NvimTreeActionsExpandAll
---@field file_popup? NvimTreeActionsFilePopup
---@field open_file? NvimTreeActionsOpenFile
---@field remove_file? NvimTreeActionsRemoveFile

---@class NvimTreeUpdateRootConfig
---@field enable? boolean
---@field ignore_list? string[]

---@class NvimTreeUpdateFocusedFileConfig
---@field enable? boolean
---@field update_root? NvimTreeUpdateRootConfig
---@field exclude? fun(event: string): boolean | nil

---@class NvimTreeSystemOpenConfig
---@field cmd? string
---@field args? string[]

---@class NvimTreeTrashConfig
---@field cmd? string

---@class NvimTreeTabSyncConfig
---@field open? boolean
---@field close? boolean
---@field ignore? string[]

---@class NvimTreeNotifyConfig
---@field threshold? number
---@field absolute_path? boolean

---@class NvimTreeHelpConfig
---@field sort_by? string

---@class NvimTreeUIConfirm
---@field remove? boolean
---@field trash? boolean
---@field default_yes? boolean

---@class NvimTreeUIConfig
---@field confirm? NvimTreeUIConfirm

---@class NvimTreeHijackDirectories
---@field enable? boolean
---@field auto_open? boolean

---@class NvimTreeLogTypes
---@field all? boolean
---@field config? boolean
---@field copy_paste? boolean
---@field dev? boolean
---@field diagnostics? boolean
---@field git? boolean
---@field profile? boolean
---@field watcher? boolean

---@class NvimTreeLogConfig
---@field enable? boolean
---@field truncate? boolean
---@field types? NvimTreeLogTypes

---@class NvimTreeExperimentalConfig
---@field actions? { open_file?: NvimTreeExperimentalOpenFile }

---@class NvimTreeConfig
---@field on_attach? fun(bufnr: integer) | "default"
---@field hijack_cursor? boolean
---@field auto_reload_on_write? boolean
---@field disable_netrw? boolean
---@field hijack_netrw? boolean
---@field hijack_unnamed_buffer_when_opening? boolean
---@field root_dirs? string[]
---@field prefer_startup_root? boolean
---@field sync_root_with_cwd? boolean
---@field reload_on_bufenter? boolean
---@field respect_buf_cwd? boolean
---@field select_prompts? boolean
---@field sort? NvimTreeSortConfig
---@field view? NvimTreeViewConfig
---@field renderer? NvimTreeRendererConfig
---@field git? NvimTreeGitConfig
---@field diagnostics? NvimTreeDiagnosticsConfig
---@field modified? NvimTreeModifiedConfig
---@field filters? NvimTreeFiltersConfig
---@field live_filter? NvimTreeLiveFilterConfig
---@field filesystem_watchers? NvimTreeFilesystemWatchers
---@field actions? NvimTreeActionsConfig
---@field update_focused_file? NvimTreeUpdateFocusedFileConfig
---@field system_open? NvimTreeSystemOpenConfig
---@field trash? NvimTreeTrashConfig
---@field tab? { sync?: NvimTreeTabSyncConfig }
---@field notify? NvimTreeNotifyConfig
---@field help? NvimTreeHelpConfig
---@field ui? NvimTreeUIConfig
---@field hijack_directories? NvimTreeHijackDirectories
---@field experimental? NvimTreeExperimentalConfig
---@field log? NvimTreeLogConfig
