local Pkg = require "mason-core.package"

return Pkg:new {
    schema = "registry+v1",
    name = "dummy2",
    description = [[This is a dummy2 package.]],
    licenses = {},
    categories = { Pkg.Cat.LSP },
    languages = { Pkg.Lang.Dummy2Lang },
    homepage = "https://example.com",
    source = {
        id = "pkg:mason/dummy2@1.0.0",
        install = function() end,
    },
}
