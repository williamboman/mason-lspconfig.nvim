return function()
    local configs = require "lspconfig.configs"

    configs.omnisharp_mono = require "lspconfig.server_configurations.omnisharp"
end
