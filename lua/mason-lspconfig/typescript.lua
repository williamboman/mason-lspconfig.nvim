local _ = require "mason-core.functional"
local fs = require "mason-core.fs"
local log = require "mason-core.log"
local path = require "mason-core.path"

local typescript = {}

---@param lib_dir string
function typescript.find_typescript_module_in_lib(lib_dir)
    return _.find_first(fs.sync.file_exists, {
        path.concat { lib_dir, "tsserverlibrary.js" },
        path.concat { lib_dir, "typescript.js" },
        path.concat { lib_dir, "tsserver.js" },
    })
end

---@param dir string
function typescript.tsdk(dir)
    return path.concat { dir, "node_modules", "typescript", "lib" }
end

---@param package_dir string The Mason package installation directory where a vendored Typescript installation can be found.
---@param workspace_dir string?
---@return string?, string?
function typescript.resolve_tsdk(package_dir, workspace_dir)
    if workspace_dir then
        local tsdk = typescript.tsdk(workspace_dir)
        local local_tsserverlib = typescript.find_typescript_module_in_lib(tsdk)
        if local_tsserverlib then
            return tsdk, local_tsserverlib
        end
    end

    local tsdk = typescript.tsdk(package_dir)
    local vendored_tsserverlib = typescript.find_typescript_module_in_lib(tsdk)
    if not vendored_tsserverlib then
        log.fmt_error("Failed to find vendored Typescript module in %s", package_dir)
        return nil, nil
    end
    return tsdk, vendored_tsserverlib
end

---@param package_dir string The Mason package installation directory where a vendored Typescript installation can be found.
---@param workspace_dir string?
function typescript.resolve_tsserver(package_dir, workspace_dir)
    local _, tsserver = typescript.resolve_tsdk(package_dir, workspace_dir)
    return tsserver
end

return typescript
