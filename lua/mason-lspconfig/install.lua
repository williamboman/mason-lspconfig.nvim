local notify = require "mason-lspconfig.notify"
local server_mapping = require "mason-lspconfig.mappings.server"

local M = {}

---@param pkg Package
---@param version string?
---@return InstallHandle
function M.install(pkg, version)
    local lspconfig_name = server_mapping.package_to_lspconfig[pkg.name]
    notify(("[mason-lspconfig.nvim] installing %s"):format(lspconfig_name))
    return pkg:install({ version = version }):once(
        "closed",
        vim.schedule_wrap(function()
            if pkg:is_installed() then
                notify(("[mason-lspconfig.nvim] %s was successfully installed"):format(lspconfig_name))
            else
                notify(
                    ("[mason-lspconfig.nvim] failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(
                        lspconfig_name
                    ),
                    vim.log.levels.ERROR
                )
            end
        end)
    )
end

return M
