local path = require "mason-core.path"
local process = require "mason-core.process"

---@param install_dir string
return function(install_dir)
    return {
        cmd_env = {
            PATH = process.extend_path {
                vim.fn.expand(path.concat { install_dir, "llvm*", "bin" }, true, true)[1],
            },
        },
    }
end
