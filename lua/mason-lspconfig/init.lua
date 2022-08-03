local log = require "mason-core.log"
local _ = require "mason-core.functional"

local M = {}

---@param config MasonLspconfigSettings | nil
function M.setup(config)
    local settings = require "mason-lspconfig.settings"

    if config then
        settings.set(config)
    end

    require "mason-lspconfig.lspconfig_hook"()

    if #settings.current.ensure_installed > 0 then
        require "mason-lspconfig.ensure_installed"()
    end

    require "mason-lspconfig.api.command"
end

---See `:h mason-lspconfig.setup_handlers()`
---@param handlers table<string, fun(server_name: string)>
function M.setup_handlers(handlers)
    local Optional = require "mason-core.optional"
    local server_mapping = require "mason-lspconfig.mappings.server"
    local registry = require "mason-registry"
    local notify = require "mason-core.notify"

    local default_handler = Optional.of_nilable(handlers[1])

    _.each(function(handler)
        if type(handler) == "string" and not server_mapping.lspconfig_to_package[handler] then
            notify(
                ("mason-lspconfig.setup_handlers: Received handler for unknown lspconfig server name: %s."):format(
                    handler
                ),
                vim.log.levels.WARN
            )
        end
    end, _.keys(handlers))

    ---@param pkg_name string
    local function get_server_name(pkg_name)
        return Optional.of_nilable(server_mapping.package_to_lspconfig[pkg_name])
    end

    local function call_handler(server_name)
        log.fmt_trace("Checking handler for %s", server_name)
        Optional.of_nilable(handlers[server_name]):or_(_.always(default_handler)):if_present(function(handler)
            log.fmt_trace("Calling handler for %s", server_name)
            local ok, err = pcall(handler, server_name)
            if not ok then
                vim.notify(err, vim.log.levels.ERROR)
            end
        end)
    end

    local installed_servers = _.filter_map(get_server_name, registry.get_installed_package_names())
    _.each(call_handler, installed_servers)
    registry:on(
        "package:install:success",
        vim.schedule_wrap(function(pkg)
            get_server_name(pkg.name):if_present(call_handler)
        end)
    )
end

---@return string[]
function M.get_installed_servers()
    local Optional = require "mason-core.optional"
    local registry = require "mason-registry"
    local server_mapping = require "mason-lspconfig.mappings.server"

    return _.filter_map(function(pkg_name)
        return Optional.of_nilable(server_mapping.package_to_lspconfig[pkg_name])
    end, registry.get_installed_package_names())
end

---Get a list of available servers in mason-registry
---@param filter {filetype: string}? (optional) used to filter the list of server names
--    The available keys are
--    - filetype (string): Only return servers with matching fileyupe
---@return string[]
function M.get_available_servers(filter)
    local registry = require "mason-registry"
    local server_mapping = require "mason-lspconfig.mappings.server"
    local Optional = require "mason-core.optional"
    local filetype_mapping = require "mason-lspconfig.mappings.filetype"
    filter = filter or {}
    return Optional.of_nilable(filetype_mapping[filter.filetype])
        :map(function(server_names)
            return server_names
        end)
        :or_else_get(function()
            return _.filter_map(function(pkg_name)
                return Optional.of_nilable(server_mapping.package_to_lspconfig[pkg_name])
            end, registry.get_all_package_names())
        end)
end

return M
