local _ = require "mason-core.functional"
local log = require "mason-core.log"
local platform = require "mason-core.platform"
local settings = require "mason-lspconfig.settings"

local M = {}

local function check_and_notify_bad_setup_order()
    local mason_ok, mason = pcall(require, "mason")
    local is_bad_order = not mason_ok or mason.has_setup == false
    local impacts_functionality = not mason_ok or #settings.current.ensure_installed > 0
    if is_bad_order and impacts_functionality then
        require "mason-lspconfig.notify"(
            "mason.nvim has not been set up. Make sure to set up 'mason' before 'mason-lspconfig'. :h mason-lspconfig-quickstart",
            vim.log.levels.WARN
        )
    end
end

---@param config MasonLspconfigSettings | nil
function M.setup(config)
    if config then
        settings.set(config)
    end

    check_and_notify_bad_setup_order()

    local ok, err = pcall(function()
        require "mason-lspconfig.lspconfig_hook"()
        require "mason-lspconfig.server_config_extensions"()
    end)
    if not ok then
        log.error("Failed to set up lspconfig integration.", err)
    end

    if not platform.is_headless and #settings.current.ensure_installed > 0 then
        require "mason-lspconfig.ensure_installed"()
    end

    local registry = require "mason-registry"
    if registry.register_package_aliases then
        registry.register_package_aliases(_.map(function(server_name)
            return { server_name }
        end, require("mason-lspconfig.mappings.server").package_to_lspconfig))
    end

    require "mason-lspconfig.api.command"

    if settings.current.handlers then
        M.setup_handlers(settings.current.handlers)
    end
end

---See `:h mason-lspconfig.setup_handlers()`
---@param handlers table<string, fun(server_name: string)>
function M.setup_handlers(handlers)
    local Optional = require "mason-core.optional"
    local server_mapping = require "mason-lspconfig.mappings.server"
    local registry = require "mason-registry"
    local notify = require "mason-lspconfig.notify"

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
                notify(err, vim.log.levels.ERROR)
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

---@param filetype string | string[]
local function is_server_in_filetype(filetype)
    local filetype_mapping = require "mason-lspconfig.mappings.filetype"

    local function get_servers_by_filetype(ft)
        return filetype_mapping[ft] or {}
    end

    local server_candidates = _.compose(
        _.set_of,
        _.cond {
            { _.is "string", get_servers_by_filetype },
            { _.is "table", _.compose(_.flatten, _.map(get_servers_by_filetype)) },
            { _.T, _.always {} },
        }
    )(filetype)

    ---@param server_name string
    ---@return boolean
    return function(server_name)
        return server_candidates[server_name]
    end
end

---Get a list of available servers in mason-registry
---@param filter { filetype: string | string[] }?: (optional) Used to filter the list of server names.
--- The available keys are
---   - filetype (string | string[]): Only return servers with matching filetype
---@return string[]
function M.get_available_servers(filter)
    local registry = require "mason-registry"
    local server_mapping = require "mason-lspconfig.mappings.server"
    local Optional = require "mason-core.optional"
    filter = filter or {}
    local predicates = {}

    if filter.filetype then
        table.insert(predicates, is_server_in_filetype(filter.filetype))
    end

    return _.filter_map(function(pkg_name)
        return Optional.of_nilable(server_mapping.package_to_lspconfig[pkg_name]):map(function(server_name)
            if #predicates == 0 or _.all_pass(predicates, server_name) then
                return server_name
            end
        end)
    end, registry.get_all_package_names())
end

---Returns the "lspconfig <-> mason" mapping tables.
---@return { lspconfig_to_mason: table<string, string>, mason_to_lspconfig: table<string, string> }
function M.get_mappings()
    local mappings = require "mason-lspconfig.mappings.server"
    return {
        lspconfig_to_mason = mappings.lspconfig_to_package,
        mason_to_lspconfig = mappings.package_to_lspconfig,
    }
end

return M
