local Pkg = require "mason-core.package"

return Pkg:new {
    schema = "registry+v1",
    name = "dummy",
    description = [[This is a dummy package.]],
    licenses = {},
    categories = { Pkg.Cat.LSP },
    languages = { Pkg.Lang.DummyLang },
    homepage = "https://example.com",
    source = {
        id = "pkg:mason/dummy@1.0.0",
        install = function() end,
    },
}
