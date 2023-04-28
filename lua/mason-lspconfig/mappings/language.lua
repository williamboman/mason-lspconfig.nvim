local _ = require "mason-core.functional"
local registry = require "mason-registry"

local M = {}

---Returns a map of language (lowercased) to one or more corresponding Mason package names.
---@return table<string, string[]>
function M.get_language_map()
    if not registry.get_all_package_specs then
        return {}
    end
    ---@type table<string, string[]>
    local languages = {}
    for _, pkg_spec in ipairs(registry.get_all_package_specs()) do
        for _, language in ipairs(pkg_spec.languages) do
            language = language:lower()
            if not languages[language] then
                languages[language] = {}
            end
            table.insert(languages[language], pkg_spec.name)
        end
    end
    return languages
end

return M
