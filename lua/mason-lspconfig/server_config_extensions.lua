return function()
    local configs = require "lspconfig.configs"

    configs.omnisharp_mono = require "lspconfig.configs.omnisharp"
end
