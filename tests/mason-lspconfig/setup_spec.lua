local match = require "luassert.match"
local stub = require "luassert.stub"
local spy = require "luassert.spy"

local Pkg = require "mason-core.package"
local mason_lspconfig = require "mason-lspconfig"
local server_mappings = require "mason-lspconfig.mappings.server"
local registry = require "mason-registry"
local filetype_mappings = require "mason-lspconfig.mappings.filetype"

describe("mason-lspconfig setup", function()
    before_each(function()
        server_mappings.lspconfig_to_package["dummylsp"] = "dummy"
        server_mappings.lspconfig_to_package["dummy2lsp"] = "dummy2"
        server_mappings.package_to_lspconfig["dummy"] = "dummylsp"
        server_mappings.package_to_lspconfig["dummy2"] = "dummy2lsp"
        filetype_mappings.dummylang = { "dummylsp", "dummy2lsp" }
        require("lspconfig.util").on_setup = nil
        local settings = require "mason-lspconfig.settings"
        settings.set(settings._DEFAULT_SETTINGS)
        vim.fn.delete(vim.env.INSTALL_ROOT_DIR, "rf")
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
            spy.on(Pkg, "install")

            mason_lspconfig.setup { ensure_installed = { "dummylsp@1.0.0" } }

            assert.spy(Pkg.install).was_called(1)
            assert.spy(Pkg.install).was_called_with(match.ref(dummy), {
                version = "1.0.0",
            })
            assert.wait_for(function()
                assert.is_true(dummy.handle:is_closed())
            end)
        end)
    )

    it(
        "should notify when installing servers listed in ensure_installed",
        async_test(function()
            spy.on(vim, "notify")
            spy.on(Pkg, "install")

            mason_lspconfig.setup { ensure_installed = { "dummylsp" } }

            assert.spy(vim.notify).was_called(1)
            assert
                .spy(vim.notify)
                .was_called_with([[[mason-lspconfig.nvim] installing dummylsp]], vim.log.levels.INFO, { title = "mason.nvim" })
        end)
    )

    it(
        "should automatically install servers",
        async_test(function()
            local dummy = registry.get_package "dummy"
            local dummy2 = registry.get_package "dummy2"
            spy.on(Pkg, "install")

            mason_lspconfig.setup { automatic_installation = true }
            local lspconfig = require "lspconfig"
            spy.on(lspconfig.dummylsp, "setup")
            spy.on(lspconfig.dummy2lsp, "setup")
            lspconfig.dummylsp.setup {}
            lspconfig.dummy2lsp.setup {}

            assert.spy(Pkg.install).was_called(2)
            assert.spy(Pkg.install).was_called_with(match.ref(dummy))
            assert.spy(Pkg.install).was_called_with(match.ref(dummy2))

            assert.wait_for(function()
                assert.is_true(dummy.handle:is_closed())
                assert.is_true(dummy2.handle:is_closed())
                assert.spy(lspconfig.dummylsp.setup).was_called(2)
                assert.spy(lspconfig.dummy2lsp.setup).was_called(2)
            end)
        end)
    )

    it("should apply mason-lspconfig server configs", function()
        stub(registry, "is_installed")
        registry.is_installed.on_call_with("dummy").returns(true)
        server_mappings.lspconfig_to_package["dummylsp"] = "dummy"
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
        server_mappings.lspconfig_to_package["dummylsp"] = "dummy"
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
end)

describe("mason-lspconfig setup_handlers", function()
    before_each(function()
        server_mappings.lspconfig_to_package["dummylsp"] = "dummy"
        server_mappings.lspconfig_to_package["dummy2lsp"] = "dummy2"
        server_mappings.package_to_lspconfig["dummy"] = "dummylsp"
        server_mappings.package_to_lspconfig["dummy2"] = "dummy2lsp"
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

    it("should print warning if registering handler for non-existent server name", function()
        spy.on(vim, "notify")
        mason_lspconfig.setup_handlers {
            doesnt_exist_server = spy.new(),
        }
        assert.spy(vim.notify).was_called(1)
        assert.spy(vim.notify).was_called_with(
            "mason-lspconfig.setup_handlers: Received handler for unknown lspconfig server name: doesnt_exist_server.",
            vim.log.levels.WARN,
            { title = "mason.nvim" }
        )
    end)

    it("should print warning when providing invalid server entries in ensure_installed", function()
        spy.on(vim, "notify")
        mason_lspconfig.setup {
            ensure_installed = { "yamllint", "hadolint" },
        }
        assert.spy(vim.notify).was_called(2)
        assert.spy(vim.notify).was_called_with(
            [[[mason-lspconfig.nvim] Server "yamllint" is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names.]],
            vim.log.levels.WARN,
            { title = "mason.nvim" }
        )
        assert.spy(vim.notify).was_called_with(
            [[[mason-lspconfig.nvim] Server "hadolint" is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names.]],
            vim.log.levels.WARN,
            { title = "mason.nvim" }
        )
    end)
end)
