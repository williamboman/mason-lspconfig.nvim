return function()
    return {
        drools = {
            jar = require("mason-core.path").concat {
                require("mason-registry").get_package("drools-lsp"):get_install_path(),
                "drools-lsp-server-jar-with-dependencies.jar",
            },
        },
    }
end
