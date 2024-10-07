local path = require "mason-core.path"

---@param install_dir string
return function(install_dir)
    return {
        drools = {
            jar = path.concat { install_dir, "drools-lsp-server-jar-with-dependencies.jar" },
        },
    }
end
