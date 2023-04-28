local match = require "luassert.match"
local spy = require "luassert.spy"
local stub = require "luassert.stub"

local Pkg = require "mason-core.package"
local a = require "mason-core.async"
local filetype_mappings = require "mason-lspconfig.mappings.filetype"
local mason_lspconfig = require "mason-lspconfig"
local platform = require "mason-core.platform"
local registry = require "mason-registry"

describe("mason-lspconfig setup", function()
    before_each(function()
        filetype_mappings.dummylang = { "dummylsp", "dummy2lsp" }
        require("lspconfig.util").on_setup = nil
        local settings = require "mason-lspconfig.settings"
        settings.set(settings._DEFAULT_SETTINGS)

        for _, pkg in ipairs(registry.get_all_packages()) do
            pkg:uninstall()
        end
    end)

    it("should set up user commands", function()
        mason_lspconfig.setup()
        local user_commands = vim.api.nvim_get_commands {}

        assert.is_true(match.tbl_containing {
            bang = false,
            bar = false,
            nargs = "*",
            complete = "custom",
            definition = "Install one or more LSP servers.",
        }(user_commands["LspInstall"]))

        assert.is_true(match.tbl_containing {
            bang = false,
            bar = false,
            definition = "Uninstall one or more LSP servers.",
            nargs = "+",
            complete = "custom",
        }(user_commands["LspUninstall"]))
    end)

    it(
        "should install servers listed in ensure_installed",
        async_test(function()
            local dummy = registry.get_package "dummy"
            local fail_dummy = registry.get_package "fail_dummy"
            spy.on(Pkg, "install")

            platform.is_headless = false
            mason_lspconfig.setup { ensure_installed = { "dummylsp@1.0.0", "fail_dummylsp" } }
            a.wait(vim.schedule)

            assert.spy(Pkg.install).was_called(2)
            assert.spy(Pkg.install).was_called_with(match.ref(dummy), { version = "1.0.0" })
            assert.spy(Pkg.install).was_called_with(match.ref(fail_dummy), { version = nil })
            assert.wait_for(function()
                assert.is_true(dummy.handle:is_closed())
                assert.is_true(fail_dummy.handle:is_closed())
            end)
        end)
    )

    it(
        "should not install servers listed in ensure_installed when headless",
        async_test(function()
            spy.on(Pkg, "install")

            platform.is_headless = true
            mason_lspconfig.setup { ensure_installed = { "dummylsp@1.0.0", "fail_dummylsp" } }

            a.wait(vim.schedule)
            assert.spy(Pkg.install).was_called(0)
        end)
    )

    it(
        "should notify when installing servers listed in ensure_installed",
        async_test(function()
            spy.on(vim, "notify")

            platform.is_headless = false
            mason_lspconfig.setup { ensure_installed = { "dummylsp", "fail_dummylsp" } }

            a.wait(vim.schedule)

            assert.spy(vim.notify).was_called(2)
            assert
                .spy(vim.notify)
                .was_called_with(
                    [[[mason-lspconfig.nvim] installing dummylsp]],
                    vim.log.levels.INFO,
                    { title = "mason-lspconfig.nvim" }
                )
            assert.spy(vim.notify).was_called_with(
                [[[mason-lspconfig.nvim] installing fail_dummylsp]],
                vim.log.levels.INFO,
                { title = "mason-lspconfig.nvim" }
            )

            assert.wait_for(function()
                assert.spy(vim.notify).was_called_with(
                    [[[mason-lspconfig.nvim] dummylsp was successfully installed]],
                    vim.log.levels.INFO,
                    { title = "mason-lspconfig.nvim" }
                )
                assert.spy(vim.notify).was_called_with(
                    [[[mason-lspconfig.nvim] failed to install fail_dummylsp. Installation logs are available in :Mason and :MasonLog]],
                    vim.log.levels.ERROR,
                    { title = "mason-lspconfig.nvim" }
                )
            end)
        end)
    )

    it(
        "should notify when installing servers via automatic installation",
        async_test(function()
            local dummy = registry.get_package "dummy"
            local fail_dummy = registry.get_package "fail_dummy"
            spy.on(Pkg, "install")
            spy.on(vim, "notify")

            platform.is_headless = false
            mason_lspconfig.setup { automatic_installation = true }
            local lspconfig = require "lspconfig"
            lspconfig.dummylsp.setup {}
            lspconfig.fail_dummylsp.setup {}

            assert.spy(Pkg.install).was_called(2)
            assert.spy(Pkg.install).was_called_with(match.ref(dummy), {})
            assert.spy(Pkg.install).was_called_with(match.ref(fail_dummy), {})

            assert
                .spy(vim.notify)
                .was_called_with(
                    [[[mason-lspconfig.nvim] installing dummylsp]],
                    vim.log.levels.INFO,
                    { title = "mason-lspconfig.nvim" }
                )
            assert.spy(vim.notify).was_called_with(
                [[[mason-lspconfig.nvim] installing fail_dummylsp]],
                vim.log.levels.INFO,
                { title = "mason-lspconfig.nvim" }
            )
            assert.wait_for(function()
                assert.is_true(dummy.handle:is_closed())
                assert.is_true(fail_dummy.handle:is_closed())
                assert.spy(vim.notify).was_called_with(
                    [[[mason-lspconfig.nvim] dummylsp was successfully installed]],
                    vim.log.levels.INFO,
                    { title = "mason-lspconfig.nvim" }
                )
                assert.spy(vim.notify).was_called_with(
                    [[[mason-lspconfig.nvim] failed to install fail_dummylsp. Installation logs are available in :Mason and :MasonLog]],
                    vim.log.levels.ERROR,
                    { title = "mason-lspconfig.nvim" }
                )
            end)
        end)
    )

    it(
        "should automatically install servers",
        async_test(function()
            local dummy = registry.get_package "dummy"
            local dummy2 = registry.get_package "dummy2"
            spy.on(Pkg, "install")

            platform.is_headless = false
            mason_lspconfig.setup { automatic_installation = true }
            local lspconfig = require "lspconfig"
            spy.on(lspconfig.dummylsp, "setup")
            spy.on(lspconfig.dummy2lsp, "setup")
            lspconfig.dummylsp.setup {}
            lspconfig.dummy2lsp.setup {}

            assert.spy(Pkg.install).was_called(2)
            assert.spy(Pkg.install).was_called_with(match.ref(dummy), {})
            assert.spy(Pkg.install).was_called_with(match.ref(dummy2), {})

            assert.wait_for(function()
                assert.is_true(dummy.handle:is_closed())
                assert.is_true(dummy2.handle:is_closed())
                assert.spy(lspconfig.dummylsp.setup).was_called(2)
                assert.spy(lspconfig.dummy2lsp.setup).was_called(2)
            end)
        end)
    )

    it(
        "should not automatically install servers when headless",
        async_test(function()
            spy.on(Pkg, "install")

            platform.is_headless = true
            mason_lspconfig.setup { automatic_installation = true }
            local lspconfig = require "lspconfig"
            spy.on(lspconfig.dummylsp, "setup")
            spy.on(lspconfig.dummy2lsp, "setup")
            lspconfig.dummylsp.setup {}
            lspconfig.dummy2lsp.setup {}

            assert.spy(Pkg.install).was_called(0)
        end)
    )

    it("should apply mason-lspconfig server configs", function()
        stub(registry, "is_installed")
        registry.is_installed.on_call_with("dummy").returns(true)
        package.loaded["mason-lspconfig.server_configurations.dummylsp"] = function()
            return { cmd = { "mason-cmd" } }
        end
        local config = { name = "dummylsp" }

        mason_lspconfig.setup()
        local on_setup = require("lspconfig.util").on_setup
        on_setup(config)

        assert.same({ name = "dummylsp", cmd = { "mason-cmd" } }, config)
    end)

    it("should let user config take precedence", function()
        stub(registry, "is_installed")
        registry.is_installed.on_call_with("dummy").returns(true)
        package.loaded["mason-lspconfig.server_configurations.dummylsp"] = function()
            return { cmd = { "mason-cmd" } }
        end
        local config = { name = "dummylsp" }
        local user_config = { cmd = { "user-cmd" } }

        mason_lspconfig.setup()
        local on_setup = require("lspconfig.util").on_setup
        on_setup(config, user_config)

        assert.same({ name = "dummylsp", cmd = { "user-cmd" } }, config)
    end)

    it("should set up package aliases", function()
        stub(registry, "register_package_aliases")

        local mapping_mock = mockx.table(require "mason-lspconfig.mappings.server", "package_to_lspconfig", {
            ["rust-analyzer"] = "rust_analyzer",
            ["typescript-language-server"] = "tsserver",
        })

        mason_lspconfig.setup {}

        assert.spy(registry.register_package_aliases).was_called(1)
        assert.spy(registry.register_package_aliases).was_called_with {
            ["rust-analyzer"] = { "rust_analyzer" },
            ["typescript-language-server"] = { "tsserver" },
        }
        mapping_mock:revert()
    end)
end)

describe("mason-lspconfig setup_handlers", function()
    before_each(function()
        filetype_mappings.dummylang = { "dummylsp", "dummy2lsp" }
        require("lspconfig.util").on_setup = nil
        local settings = require "mason-lspconfig.settings"
        settings.set(settings._DEFAULT_SETTINGS)
    end)

    it("should call default handler", function()
        stub(registry, "get_installed_package_names")
        registry.get_installed_package_names.returns { "dummy" }
        local default_handler = spy.new()

        mason_lspconfig.setup_handlers { default_handler }

        assert.spy(default_handler).was_called(1)
        assert.spy(default_handler).was_called_with "dummylsp"
    end)

    it("should call dedicated handler", function()
        stub(registry, "get_installed_package_names")
        registry.get_installed_package_names.returns { "dummy" }
        local dedicated_handler = spy.new()
        local default_handler = spy.new()

        mason_lspconfig.setup_handlers {
            default_handler,
            ["dummylsp"] = dedicated_handler,
        }

        assert.spy(default_handler).was_called(0)
        assert.spy(dedicated_handler).was_called(1)
        assert.spy(dedicated_handler).was_called_with "dummylsp"
    end)

    it("(via .setup {}) should call default handler", function()
        stub(registry, "get_installed_package_names")
        registry.get_installed_package_names.returns { "dummy" }
        local default_handler = spy.new()

        mason_lspconfig.setup { handlers = { default_handler } }

        assert.spy(default_handler).was_called(1)
        assert.spy(default_handler).was_called_with "dummylsp"
    end)

    it("(via .setup {}) should call dedicated handler", function()
        stub(registry, "get_installed_package_names")
        registry.get_installed_package_names.returns { "dummy" }
        local dedicated_handler = spy.new()
        local default_handler = spy.new()

        mason_lspconfig.setup {
            handlers = {
                default_handler,
                ["dummylsp"] = dedicated_handler,
            },
        }

        assert.spy(default_handler).was_called(0)
        assert.spy(dedicated_handler).was_called(1)
        assert.spy(dedicated_handler).was_called_with "dummylsp"
    end)

    it("should print warning if registering handler for non-existent server name", function()
        spy.on(vim, "notify")
        mason_lspconfig.setup_handlers {
            doesnt_exist_server = spy.new(),
        }
        assert.spy(vim.notify).was_called(1)
        assert.spy(vim.notify).was_called_with(
            "mason-lspconfig.setup_handlers: Received handler for unknown lspconfig server name: doesnt_exist_server.",
            vim.log.levels.WARN,
            { title = "mason-lspconfig.nvim" }
        )
    end)

    it(
        "should print warning when providing invalid server entries in ensure_installed",
        async_test(function()
            spy.on(vim, "notify")
            platform.is_headless = false
            mason_lspconfig.setup {
                ensure_installed = { "yamllint", "hadolint" },
            }

            a.wait(vim.schedule)
            assert.spy(vim.notify).was_called(2)
            assert.spy(vim.notify).was_called_with(
                [[[mason-lspconfig.nvim] Server "yamllint" is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names.]],
                vim.log.levels.WARN,
                { title = "mason-lspconfig.nvim" }
            )
            assert.spy(vim.notify).was_called_with(
                [[[mason-lspconfig.nvim] Server "hadolint" is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names.]],
                vim.log.levels.WARN,
                { title = "mason-lspconfig.nvim" }
            )
        end)
    )

    it("should notify if mason.nvim has not been set up and using ensure_installed feature", function()
        package.loaded["mason"] = nil
        spy.on(vim, "notify")

        mason_lspconfig.setup { ensure_installed = { "dummylsp" } }
        assert.spy(vim.notify).was_called(1)
        assert.spy(vim.notify).was_called_with(
            [[mason.nvim has not been set up. Make sure to set up 'mason' before 'mason-lspconfig'. :h mason-lspconfig-quickstart]],
            vim.log.levels.WARN,
            { title = "mason-lspconfig.nvim" }
        )
    end)

    it("should not notify if mason.nvim has not been set up and not using ensure_installed feature", function()
        package.loaded["mason"] = nil
        spy.on(vim, "notify")

        mason_lspconfig.setup()
        assert.spy(vim.notify).was_called(0)
    end)

    it("should notify is server is set up before mason.nvim", function()
        package.loaded["mason"] = nil
        local lspconfig = require "lspconfig"
        spy.on(vim, "notify")

        mason_lspconfig.setup()
        lspconfig.dummylsp.setup {}

        assert.spy(vim.notify).was_called(1)
        assert.spy(vim.notify).was_called_with(
            [[Server "dummylsp" is being set up before mason.nvim is set up. :h mason-lspconfig-quickstart]],
            vim.log.levels.WARN,
            { title = "mason-lspconfig.nvim" }
        )
    end)
end)
