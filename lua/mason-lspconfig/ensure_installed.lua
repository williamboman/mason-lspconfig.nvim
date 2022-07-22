local settings = require "mason-lspconfig.settings"

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
    for _, server_identifier in ipairs(settings.current.ensure_installed) do
        local Package = require "mason-core.package"

        local server_name, version = Package.Parse(server_identifier)
        resolve_package(server_name):if_present(
            ---@param pkg Package
            function(pkg)
                if not pkg:is_installed() then
                    pkg:install {
                        version = version,
                    }
                end
            end
        )
    end
end
