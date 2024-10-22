local path = require "mason-core.path"
local process = require "mason-core.process"

---@param install_dir string
return function(install_dir)
    local llvm_bins = { vim.fn.expand(path.concat { install_dir, "llvm*", "bin" }, true, true)[1] }
    if vim.env.MASON then
        table.insert(llvm_bins, vim.fn.expand "$MASON/opt/solang/llvm15.0/bin")
    end
    return {
        cmd_env = {
            PATH = process.extend_path(llvm_bins),
        },
    }
end
