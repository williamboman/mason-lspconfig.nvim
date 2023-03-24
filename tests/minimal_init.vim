" Avoid neovim/neovim#11362
set display=lastline
set directory=""
set noswapfile

let $mason = getcwd()
let $test_helpers = getcwd() .. "/tests/helpers"
let $dependencies = getcwd() .. "/dependencies"

set rtp^=$mason,$test_helpers
set packpath=$dependencies

packloadall

lua require("luassertx")
lua require("test_helpers")

lua <<EOF
local configs = require 'lspconfig.configs'
configs.dummylsp = { default_config = { cmd = { "dummylsp" } } }
configs.dummy2lsp = { default_config = { cmd = { "dummy2lsp"} } }
configs.fail_dummylsp = { default_config = { cmd = { "fail_dummylsp"} } }

local server_mappings = require "mason-lspconfig.mappings.server"
server_mappings.lspconfig_to_package["dummylsp"] = "dummy"
server_mappings.lspconfig_to_package["dummy2lsp"] = "dummy2"
server_mappings.lspconfig_to_package["fail_dummylsp"] = "fail_dummy"
server_mappings.package_to_lspconfig["dummy"] = "dummylsp"
server_mappings.package_to_lspconfig["dummy2"] = "dummy2lsp"
server_mappings.package_to_lspconfig["fail_dummy"] = "fail_dummylsp"

require("mason").setup {
    install_root_dir = vim.env.INSTALL_ROOT_DIR,
    registries = {
        "lua:dummy-registry.index"
    }
}
EOF

function! RunTests() abort
    lua <<EOF
    require("plenary.test_harness").test_directory(os.getenv("FILE") or "./tests", {
        minimal_init = vim.fn.getcwd() .. "/tests/minimal_init.vim",
        sequential = true,
    })
EOF
endfunction
