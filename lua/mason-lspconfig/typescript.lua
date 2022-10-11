local _ = require "mason-core.functional"
local fs = require "mason-core.fs"
local path = require "mason-core.path"
local log = require "mason-core.log"

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
---@param workspace_dir string
---@return string
function typescript.resolve_server_path(package_dir, workspace_dir)
    local local_tsserverlib = workspace_dir ~= nil
        and typescript.find_typescript_module_in_lib(typescript.tsdk(workspace_dir))
    if local_tsserverlib then
        return local_tsserverlib
    else
        local vendored_tsserverlib = typescript.find_typescript_module_in_lib(typescript.tsdk(package_dir))
        if not vendored_tsserverlib then
            log.fmt_error("Failed to find vendored Typescript module in %s", package_dir)
        end
        return vendored_tsserverlib
    end
end

return typescript
