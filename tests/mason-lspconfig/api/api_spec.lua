local _ = require "mason-core.functional"
local mason_lspconfig = require "mason-lspconfig"

describe("mason-lspconfig API", function()
    it("should return all available servers", function()
        local available_servers = mason_lspconfig.get_available_servers()
        assert.equals(vim.tbl_count(require "dummy-registry.index"), #available_servers)
    end)

    it("should return all available servers for given filetype", function()
        require("mason-lspconfig.mappings.filetype").dummylang = {
            "dummylsp",
            "dummy2lsp",
        }
        assert.same(
            { "dummy2lsp", "dummylsp" },
            _.sort_by(
                _.identity,
                mason_lspconfig.get_available_servers {
                    filetype = "dummylang",
                }
            )
        )
    end)

    it("should return all available servers for given filetypes", function()
        require("mason-lspconfig.mappings.filetype").dummylang = {
            "dummylsp",
        }
        require("mason-lspconfig.mappings.filetype").madeuplang = {
            "dummy2lsp",
        }
        assert.same(
            { "dummy2lsp", "dummylsp" },
            _.sort_by(
                _.identity,
                mason_lspconfig.get_available_servers {
                    filetype = { "dummylang", "madeuplang" },
                }
            )
        )
    end)

    it("should return no servers if filetype predicate has no matches", function()
        assert.same(
            {},
            mason_lspconfig.get_available_servers {
                filetype = { "thisfiletypesimplydoesntexist" },
            }
        )
    end)
end)
