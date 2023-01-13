return function()
    return {
        on_new_config = function(new_config)
            -- if the user configured a cmd, we just use that
            if not new_config.cmd then
                -- otherwise, we look to see if they set the location of the drools jar
                local drools_jar = vim.tbl_get(new_config.settings, "drools", "jar")
                        and new_config.settings["drools"]["jar"]
                    or nil
                if drools_jar ~= nil then
                    -- if the drools jar location was set, we re-use the logic in the default_config
                    local default_config = require("lspconfig.server_configurations.drools_lsp").default_config
                    return default_config.on_new_config(new_config)
                else
                    -- otherwise, we fall back to the shell_exec_wrapper that mason generated
                    new_config.cmd = { "drools-lsp" }
                end
            end
        end,
    }
end
