local settings = require "mason-lspconfig.settings"
local notify = require "mason-core.notify"
local completed_event = "MasonLspConfigEnsureInstallCompleted"
local success_event = "MasonLspConfigEnsureInstallSuccessful"
local fail_event = "MasonLspConfigEnsureInstallError"

---@param lspconfig_server_name string
local function resolve_package(lspconfig_server_name)
    local registry = require "mason-registry"
    local Optional = require "mason-core.optional"
    local server_mapping = require "mason-lspconfig.mappings.server"

    return Optional.of_nilable(server_mapping.lspconfig_to_package[lspconfig_server_name]):map(function(package_name)
        local ok, pkg = pcall(registry.get_package, package_name)
        if ok then
            return pkg
        end
    end)
end

return function()
    local installing = -1
    local error = false
    for _, server_identifier in ipairs(settings.current.ensure_installed) do
        local Package = require "mason-core.package"

        local server_name, version = Package.Parse(server_identifier)
        resolve_package(server_name)
            :if_present(
                ---@param pkg Package
                function(pkg)
                    if not pkg:is_installed() then
                        if installing < 0 then
                            installing = 0
                        end
                        installing = installing + 1
                        notify(("[mason-lspconfig.nvim] installing %s"):format(server_name))
                        pkg:install({
                            version = version,
                        }):on("closed", function()
                            if not pkg:is_installed() then
                                error = true
                            end
                            installing = installing - 1
                            if installing == 0 then
                                vim.schedule(function()
                                    vim.cmd("doautocmd User " .. completed_event)
                                    if error then
                                        vim.cmd("doautocmd User " .. fail_event)
                                    else
                                        vim.cmd("doautocmd User " .. success_event)
                                    end
                                end)
                            end
                        end)
                    end
                end
            )
            :if_not_present(function()
                notify(
                    ("[mason-lspconfig.nvim] Server %q is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names."):format(
                        server_name
                    ),
                    vim.log.levels.WARN
                )
            end)
    end
    if installing < 0 then
        vim.schedule(function()
            vim.cmd("doautocmd User " .. completed_event)
            vim.cmd("doautocmd User " .. success_event)
        end)
    end
end
