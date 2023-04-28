local _ = require "mason-core.functional"
local log = require "mason-core.log"
local notify = require "mason-lspconfig.notify"
local path = require "mason-core.path"
local platform = require "mason-core.platform"

local memoized_set = _.memoize(_.set_of)

---@param server_name string
local function should_auto_install(server_name)
    if platform.is_headless then
        return false
    end
    local settings = require "mason-lspconfig.settings"

    if settings.current.automatic_installation == true then
        return true
    end
    if type(settings.current.automatic_installation) == "table" then
        return not memoized_set(settings.current.automatic_installation.exclude)[server_name]
    end
    return false
end

---@param lspconfig_server_name string
local function resolve_server_config_factory(lspconfig_server_name)
    local Optional = require "mason-core.optional"

    local ok, server_config = pcall(require, ("mason-lspconfig.server_configurations.%s"):format(lspconfig_server_name))
    if ok then
        return Optional.of(server_config)
    end
    return Optional.empty()
end

local merge_in_place
---@param t1 table
---@param t2 table
merge_in_place = _.curryN(function(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k]) == "table" and not vim.tbl_islist(t1[k]) then
                merge_in_place(t1[k], v)
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end, 2)

return function()
    local util = require "lspconfig.util"
    local server_mapping = require "mason-lspconfig.mappings.server"
    local registry = require "mason-registry"

    util.on_setup = util.add_hook_before(util.on_setup, function(config, user_config)
        local pkg_name = server_mapping.lspconfig_to_package[config.name]
        if not pkg_name then
            return
        end

        if require("mason").has_setup == false then
            notify(
                ("Server %q is being set up before mason.nvim is set up. :h mason-lspconfig-quickstart"):format(
                    config.name
                ),
                vim.log.levels.WARN
            )
        end

        if registry.is_installed(pkg_name) then
            resolve_server_config_factory(config.name):if_present(function(config_factory)
                local mason_config = config_factory(path.package_prefix(pkg_name), config)
                _.reduce(merge_in_place, config, { mason_config, user_config or {} })
            end)
            if platform.is.win and (config.cmd and config.cmd[1] ~= "cmd.exe") then
                local exepath = vim.fn.exepath(config.cmd[1])
                if exepath ~= "" then
                    config.cmd[1] = exepath
                else
                    log.error("Failed to expand cmd path", config.name, config.cmd)
                end
            end
        elseif should_auto_install(config.name) then
            local ok, pkg = pcall(registry.get_package, pkg_name)
            if ok then
                require("mason-lspconfig.install").install(pkg):once(
                    "closed",
                    vim.schedule_wrap(function()
                        if pkg:is_installed() then
                            -- reload config
                            require("lspconfig")[config.name].setup(config)
                        end
                    end)
                )
            end
        end
    end)
end
