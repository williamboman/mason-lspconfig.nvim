local Pkg = require "mason-core.package"

return Pkg.new {
    name = "fail_dummy",
    desc = [[This is a dummy package that fails.]],
    categories = { Pkg.Cat.LSP },
    languages = { Pkg.Lang.DummyLang },
    homepage = "https://example.com",
    install = function()
        error("fail-dummy doesn't want to be installed", 0)
    end,
}
