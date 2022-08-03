local mason_lspconfig = require "mason-lspconfig"
local _ = require "mason-core.functional"

describe("mason-lspconfig API", function()
    it("should return all available servers", function()
        assert.equals(116, #mason_lspconfig.get_available_servers())
    end)

    it("should return all available servers for given filetype", function()
        assert.same(
            { "terraformls", "tflint" },
            _.sort_by(
                _.identity,
                mason_lspconfig.get_available_servers {
                    filetype = "terraform",
                }
            )
        )
    end)

    it("should return all available servers for given filetypes", function()
        assert.same(
            { "lemminx", "taplo" },
            _.sort_by(
                _.identity,
                mason_lspconfig.get_available_servers {
                    filetype = { "xml", "xsd", "xsl", "toml" },
                }
            )
        )
    end)
end)
