local _ = require "mason-core.functional"

local M = {}

---Maps lspconfig server config name to its corresponding package name.
M.lspconfig_to_package = {
    ["als"] = "ada-language-server",
    ["angularls"] = "angular-language-server",
    ["ansiblels"] = "ansible-language-server",
    ["antlersls"] = "antlers-language-server",
    ["apex_ls"] = "apex-language-server",
    ["arduino_language_server"] = "arduino-language-server",
    ["asm_lsp"] = "asm-lsp",
    ["ast_grep"] = "ast-grep",
    ["astro"] = "astro-language-server",
    ["autotools_ls"] = "autotools-language-server",
    ["awk_ls"] = "awk-language-server",
    ["azure_pipelines_ls"] = "azure-pipelines-language-server",
    ["bashls"] = "bash-language-server",
    ["beancount"] = "beancount-language-server",
    ["bicep"] = "bicep-lsp",
    ["biome"] = "biome",
    ["bright_script"] = "brighterscript",
    ["bsl_ls"] = "bsl-language-server",
    ["bufls"] = "buf-language-server",
    ["bzl"] = "bzl",
    ["cairo_ls"] = "cairo-language-server",
    ["clangd"] = "clangd",
    ["clarity_lsp"] = "clarity-lsp",
    ["clojure_lsp"] = "clojure-lsp",
    ["cmake"] = "cmake-language-server",
    ["codeqlls"] = "codeql",
    ["crystalline"] = "crystalline",
    ["csharp_ls"] = "csharp-language-server",
    ["cssls"] = "css-lsp",
    ["cssmodules_ls"] = "cssmodules-language-server",
    ["cucumber_language_server"] = "cucumber-language-server",
    ["custom_elements_ls"] = "custom-elements-languageserver",
    ["cypher_ls"] = "cypher-language-server",
    ["dagger"] = "cuelsp",
    ["denols"] = "deno",
    ["dhall_lsp_server"] = "dhall-lsp",
    ["diagnosticls"] = "diagnostic-languageserver",
    ["docker_compose_language_service"] = "docker-compose-language-service",
    ["dockerls"] = "dockerfile-language-server",
    ["dotls"] = "dot-language-server",
    ["drools_lsp"] = "drools-lsp",
    ["efm"] = "efm",
    ["elixirls"] = "elixir-ls",
    ["elmls"] = "elm-language-server",
    ["elp"] = "elp",
    ["ember"] = "ember-language-server",
    ["emmet_language_server"] = "emmet-language-server",
    ["emmet_ls"] = "emmet-ls",
    ["erg_language_server"] = "erg-language-server",
    ["erlangls"] = "erlang-ls",
    ["esbonio"] = "esbonio",
    ["eslint"] = "eslint-lsp",
    ["facility_language_server"] = "facility-language-server",
    ["fennel_language_server"] = "fennel-language-server",
    ["flux_lsp"] = "flux-lsp",
    ["foam_ls"] = "foam-language-server",
    ["fortls"] = "fortls",
    ["fsautocomplete"] = "fsautocomplete",
    ["gleam"] = "gleam",
    ["glint"] = "glint",
    ["glsl_analyzer"] = "glsl_analyzer",
    ["golangci_lint_ls"] = "golangci-lint-langserver",
    ["gopls"] = "gopls",
    ["gradle_ls"] = "gradle-language-server",
    ["grammarly"] = "grammarly-languageserver",
    ["graphql"] = "graphql-language-service-cli",
    ["groovyls"] = "groovy-language-server",
    ["haxe_language_server"] = "haxe-language-server",
    ["hdl_checker"] = "hdl-checker",
    ["helm_ls"] = "helm-ls",
    ["hls"] = "haskell-language-server",
    ["hoon_ls"] = "hoon-language-server",
    ["html"] = "html-lsp",
    ["htmx"] = "htmx-lsp",
    ["hydra_lsp"] = "hydra-lsp",
    ["intelephense"] = "intelephense",
    ["java_language_server"] = "java-language-server",
    ["jdtls"] = "jdtls",
    ["jedi_language_server"] = "jedi-language-server",
    ["jsonls"] = "json-lsp",
    ["jsonnet_ls"] = "jsonnet-language-server",
    ["julials"] = "julia-lsp",
    ["jqls"] = "jq-lsp",
    ["kotlin_language_server"] = "kotlin-language-server",
    ["lelwel_ls"] = "lelwel",
    ["lemminx"] = "lemminx",
    ["ltex"] = "ltex-ls",
    ["lua_ls"] = "lua-language-server",
    ["luau_lsp"] = "luau-lsp",
    ["lwc_ls"] = "lwc-language-server",
    ["marksman"] = "marksman",
    ["mdx_analyzer"] = "mdx-analyzer",
    ["matlab_ls"] = "matlab-language-server",
    ["mm0_ls"] = "metamath-zero-lsp",
    ["move_analyzer"] = "move-analyzer",
    ["mutt_ls"] = "mutt-language-server",
    ["neocmake"] = "neocmakelsp",
    ["nickel_ls"] = "nickel-lang-lsp",
    ["nil_ls"] = "nil",
    ["nim_langserver"] = "nimlangserver",
    ["nimls"] = "nimlsp",
    ["ocamllsp"] = "ocaml-lsp",
    ["ols"] = "ols",
    ["omnisharp"] = "omnisharp",
    ["omnisharp_mono"] = "omnisharp-mono",
    ["opencl_ls"] = "opencl-language-server",
    ["openscad_lsp"] = "openscad-lsp",
    ["perlnavigator"] = "perlnavigator",
    ["pest_ls"] = "pest-language-server",
    ["phpactor"] = "phpactor",
    ["pkgbuild_language_server"] = "pkgbuild-language-server",
    ["powershell_es"] = "powershell-editor-services",
    ["prismals"] = "prisma-language-server",
    ["prosemd_lsp"] = "prosemd-lsp",
    ["psalm"] = "psalm",
    ["puppet"] = "puppet-editor-services",
    ["purescriptls"] = "purescript-language-server",
    ["pylsp"] = "python-lsp-server",
    ["pylyzer"] = "pylyzer",
    ["pyre"] = "pyre",
    ["pyright"] = "pyright",
    ["quick_lint_js"] = "quick-lint-js",
    ["r_language_server"] = "r-languageserver",
    ["raku_navigator"] = "raku-navigator",
    ["reason_ls"] = "reason-language-server",
    ["remark_ls"] = "remark-language-server",
    ["rescriptls"] = "rescript-language-server",
    ["rnix"] = "rnix-lsp",
    ["robotframework_ls"] = "robotframework-lsp",
    ["rome"] = "rome",
    ["ruby_ls"] = "ruby-lsp",
    ["rubocop"] = "rubocop",
    ["ruff_lsp"] = "ruff-lsp",
    ["rust_analyzer"] = "rust-analyzer",
    ["salt_ls"] = "salt-lsp",
    ["serve_d"] = "serve-d",
    ["slint_lsp"] = "slint-lsp",
    ["smithy_ls"] = "smithy-language-server",
    ["snyk_ls"] = "snyk-ls",
    ["solang"] = "solang",
    ["solargraph"] = "solargraph",
    ["solc"] = "solidity",
    ["solidity"] = "solidity-ls",
    ["solidity_ls_nomicfoundation"] = "nomicfoundation-solidity-language-server",
    ["sorbet"] = "sorbet",
    ["sourcery"] = "sourcery",
    ["spectral"] = "spectral-language-server",
    ["sqlls"] = "sqlls",
    ["sqls"] = "sqls",
    ["standardrb"] = "standardrb",
    ["stimulus_ls"] = "stimulus-language-server",
    ["stylelint_lsp"] = "stylelint-lsp",
    ["svelte"] = "svelte-language-server",
    ["svlangserver"] = "svlangserver",
    ["svls"] = "svls",
    ["swift_mesonls"] = "swift-mesonlsp",
    ["tailwindcss"] = "tailwindcss-language-server",
    ["taplo"] = "taplo",
    ["teal_ls"] = "teal-language-server",
    ["templ"] = "templ",
    ["terraformls"] = "terraform-ls",
    ["texlab"] = "texlab",
    ["tflint"] = "tflint",
    ["theme_check"] = "shopify-theme-check",
    ["thriftls"] = "thriftls",
    ["tsserver"] = "typescript-language-server",
    ["typos_lsp"] = "typos-lsp",
    ["typst_lsp"] = "typst-lsp",
    ["unocss"] = "unocss-language-server",
    ["v_analyzer"] = "v-analyzer",
    ["vala_ls"] = "vala-language-server",
    ["vale_ls"] = "vale-ls",
    ["verible"] = "verible",
    ["veryl_ls"] = "veryl-ls",
    ["vimls"] = "vim-language-server",
    ["visualforce_ls"] = "visualforce-language-server",
    ["vls"] = "vls",
    ["volar"] = "vue-language-server",
    ["vtsls"] = "vtsls",
    ["vuels"] = "vetur-vls",
    ["wgsl_analyzer"] = "wgsl-analyzer",
    ["yamlls"] = "yaml-language-server",
    ["zk"] = "zk",
    ["zls"] = "zls",
}

M.package_to_lspconfig = _.invert(M.lspconfig_to_package)

return M
