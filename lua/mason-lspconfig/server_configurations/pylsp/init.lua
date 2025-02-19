local _ = require "mason-core.functional"
local a = require "mason-core.async"

---@param install_dir string
return function(install_dir)
    vim.api.nvim_create_user_command(
        "PylspInstall",
        a.scope(function(opts)
            local notify = require "mason-lspconfig.notify"
            local pypw = require "mason-core.installer.managers.pypi"
            local process = require "mason-core.process"
            local spawn = require "mason-core.spawn"

            local plugins = opts.fargs
            local plugins_str = table.concat(plugins, ", ")
            notify(("Installing %s..."):format(plugins_str))
            local result = spawn.pip {
                "install",
                "-U",
                "--disable-pip-version-check",
                plugins,
                stdio_sink = process.StdioSink:new {
                    stdout = vim.schedule_wrap(vim.api.nvim_out_write),
                    stderr = vim.schedule_wrap(vim.api.nvim_err_write),
                },
                with_paths = { pypw.venv_path(install_dir) },
            }
            if vim.in_fast_event() then
                a.scheduler()
            end
            result
                :on_success(function()
                    notify(("Successfully installed pylsp plugins %s"):format(plugins_str))
                end)
                :on_failure(function()
                    notify("Failed to install requested pylsp plugins.", vim.log.levels.ERROR)
                end)
        end),
        {
            desc = "[mason-lspconfig.nvim] Installs the provided packages in the same venv as pylsp.",
            nargs = "+",
            complete = _.always {
                "pyls-flake8",
                "pyls-isort",
                "pyls-memestra",
                "pyls-spyder",
                "pylsp-mypy",
                "pylsp-rope",
                "python-lsp-black",
                "python-lsp-ruff",
            },
        }
    )

    return {}
end
