local Pkg = require "mason-core.package"

return Pkg:new {
    schema = "registry+v1",
    name = "fail_dummy",
    description = [[This is a dummy package that fails.]],
    licenses = {},
    categories = { Pkg.Cat.LSP },
    languages = { Pkg.Lang.DummyLang },
    homepage = "https://example.com",
    source = {
        id = "pkg:mason/fail_dummy@1.0.0",
        install = function()
            error("fail-dummy doesn't want to be installed", 0)
        end,
    },
}
