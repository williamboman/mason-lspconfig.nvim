local M = {}

---@class MasonLspconfigServerSettings
---@field server string the lspconfig server name
---@field public package string the Mason package name
---@field filetypes string[] the filetypes that the server applies to
---@field config? table|fun(): table extensions to the default language server configuration

---@class MasonLspconfigSettings
local DEFAULT_SETTINGS = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
    ---@type string[]
    ensure_installed = {},

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = false,

    -- See `:h mason-lspconfig.setup_handlers()`
    ---@type table<string, fun(server_name: string)>?
    handlers = nil,
    ---@type table<string, MasonLspconfigServerSettings>?
    servers = nil,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param opts MasonLspconfigSettings
function M.set(opts)
    M.current = vim.tbl_deep_extend("force", M.current, opts)
end

return M
