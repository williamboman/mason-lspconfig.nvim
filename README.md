[![GitHub CI](https://github.com/williamboman/mason-lspconfig.nvim/workflows/Tests/badge.svg)](https://github.com/williamboman/mason-lspconfig.nvim/actions?query=workflow%3ATests+branch%3Amain+event%3Apush)
![Platforms](https://img.shields.io/badge/platform-linux%20macOS%20windows-blue)
![Repository size](https://img.shields.io/github/repo-size/williamboman/mason-lspconfig.nvim)
[![Sponsors](https://img.shields.io/github/sponsors/williamboman?style=flat-square)](https://github.com/sponsors/williamboman)

# mason-lspconfig.nvim

<p align="center">
    <code>mason-lspconfig</code> bridges <a
    href="https://github.com/williamboman/mason.nvim"><code>mason.nvim</code></a> with the <a
    href="https://github.com/neovim/nvim-lspconfig"><code>lspconfig</code></a> plugin - making it easier to use both
    plugins together.<br />
    <code>:help mason-lspconfig.nvim</code>
</p>

# Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
  - [Automatic server setup (advanced feature)](#automatic-server-setup-advanced-feature)
- [Commands](#commands)
- [Configuration](#configuration)
  - [Default configuration](#default-configuration)
- [Available LSP servers](#available-lsp-servers)

# Introduction

> `:h mason-lspconfig-introduction`

`mason-lspconfig.nvim` closes some gaps that exist between `mason.nvim` and `lspconfig`. Its main responsibilities are to:

- register a setup hook with `lspconfig` that ensures servers installed with `mason.nvim` are set up with the necessary
    configuration
- provide extra convenience APIs such as the `:LspInstall` command
- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
- translate between `lspconfig` server names and `mason.nvim` package names (e.g. `lua_ls <-> lua-language-server`)

It is recommended to use this extension if you use `mason.nvim` and `lspconfig` (it's strongly recommended for Windows
users).

**Note: this plugin uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names. [See this
table for a complete mapping.](./doc/server-mapping.md)**

# Requirements

> `:h mason-lspconfig-requirements`

- neovim `>= 0.7.0`
- `mason.nvim`
- `lspconfig`

# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
```

# Setup

> `:h mason-lspconfig-quickstart`

It's important that you set up the plugins in the following order:

1. `mason.nvim`
2. `mason-lspconfig.nvim`
3. Setup servers via `lspconfig`

Pay extra attention to this if you lazy-load plugins, or somehow "chain" the loading of plugins via your plugin manager.

```lua
require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...
```

Refer to the [Configuration](#configuration) section for information about which settings are available.

## Automatic server setup (advanced feature)

> `:h mason-lspconfig-automatic-server-setup`

`mason-lspconfig` provides extra, opt-in, functionality that allows you to automatically set up LSP servers installed
via `mason.nvim` without having to manually add each server setup to your Neovim configuration.
Refer to `:h mason-lspconfig-automatic-server-setup` for more details.

# Commands

> `:h mason-lspconfig-commands`

- `:LspInstall [<server>...]` - installs the provided servers
- `:LspUninstall <server> ...` - uninstalls the provided servers

# Configuration

> `:h mason-lspconfig-settings`

You may optionally configure certain behavior of `mason-lspconfig.nvim` when calling the `.setup()` function. Refer to
the [default configuration](#default-configuration) for a list of all available settings.

Example:

```lua
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer" },
}
```

## Default configuration

```lua
local DEFAULT_SETTINGS = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {},

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
}
```

# Available LSP servers

| Language                            | Server name                       |
| ----------------------------------- | --------------------------------- |
| AWK                                 | `awk_ls`                          |
| Ada                                 | `als`                             |
| Angular                             | `angularls`                       |
| Ansible                             | `ansiblels`                       |
| Antlers                             | `antlersls`                       |
| Apex                                | `apex_ls`                         |
| Arduino                             | `arduino_language_server`         |
| Assembly (GAS/NASM, GO)             | `asm_lsp`                         |
| Astro                               | `astro`                           |
| Azure Pipelines                     | `azure_pipelines_ls`              |
| Bash                                | `bashls`                          |
| Beancount                           | `beancount`                       |
| Bicep                               | `bicep`                           |
| BrighterScript                      | `bright_script`                   |
| Buf                                 | `bufls`                           |
| C                                   | `clangd`                          |
| C#                                  | `csharp_ls`                       |
| C# [(docs)][omnisharp]              | `omnisharp_mono`                  |
| C# [(docs)][omnisharp]              | `omnisharp`                       |
| C++                                 | `clangd`                          |
| CMake                               | `cmake`                           |
| CMake                               | `neocmake`                        |
| CSS                                 | `cssls`                           |
| CSS                                 | `cssmodules_ls`                   |
| CSS                                 | `unocss`                          |
| Clarity                             | `clarity_lsp`                     |
| Clojure                             | `clojure_lsp`                     |
| CodeQL                              | `codeqlls`                        |
| Crystal                             | `crystalline`                     |
| Cucumber                            | `cucumber_language_server`        |
| Cue                                 | `dagger`                          |
| Deno                                | `denols`                          |
| Dhall                               | `dhall_lsp_server`                |
| Diagnostic (general purpose server) | `diagnosticls`                    |
| Dlang                               | `serve_d`                         |
| Docker                              | `dockerls`                        |
| Docker Compose                      | `docker_compose_language_service` |
| Dot                                 | `dotls`                           |
| Drools                              | `drools_lsp`                      |
| EFM (general purpose server)        | `efm`                             |
| ESLint                              | `eslint`                          |
| Elixir                              | `elixirls`                        |
| Elm                                 | `elmls`                           |
| Ember                               | `ember`                           |
| Emmet                               | `emmet_ls`                        |
| Erg                                 | `erg_language_server`             |
| Erlang                              | `erlangls`                        |
| F#                                  | `fsautocomplete`                  |
| Fennel                              | `fennel_language_server`          |
| Flux                                | `flux_lsp`                        |
| Foam (OpenFOAM)                     | `foam_ls`                         |
| Fortran                             | `fortls`                          |
| Glint                               | `glint`                           |
| Go                                  | `golangci_lint_ls`                |
| Go                                  | `gopls`                           |
| Gradle                              | `gradle_ls`                       |
| Grammarly                           | `grammarly`                       |
| GraphQL                             | `graphql`                         |
| Groovy                              | `groovyls`                        |
| HTML                                | `html`                            |
| Haskell                             | `hls`                             |
| Haxe                                | `haxe_language_server`            |
| Helm                                | `helm_ls`                         |
| Hoon                                | `hoon_ls`                         |
| JSON                                | `jsonls`                          |
| Java                                | `jdtls`                           |
| JavaScript                          | `quick_lint_js`                   |
| JavaScript                          | `tsserver`                        |
| JavaScript                          | `vtsls`                           |
| Jsonnet                             | `jsonnet_ls`                      |
| Julia [(docs)][julials]             | `julials`                         |
| Kotlin                              | `kotlin_language_server`          |
| LaTeX                               | `ltex`                            |
| LaTeX                               | `texlab`                          |
| Lelwel                              | `lelwel_ls`                       |
| Lua                                 | `lua_ls`                          |
| Luau                                | `luau_lsp`                        |
| Markdown                            | `marksman`                        |
| Markdown                            | `prosemd_lsp`                     |
| Markdown                            | `remark_ls`                       |
| Markdown                            | `zk`                              |
| Metamath Zero                       | `mm0_ls`                          |
| Move                                | `move_analyzer`                   |
| Nickel                              | `nickel_ls`                       |
| Nim                                 | `nimls`                           |
| Nix                                 | `nil_ls`                          |
| Nix                                 | `rnix`                            |
| OCaml                               | `ocamllsp`                        |
| OneScript, 1C:Enterprise            | `bsl_ls`                          |
| OpenAPI                             | `spectral`                        |
| OpenCL                              | `opencl_ls`                       |
| OpenSCAD                            | `openscad_lsp`                    |
| PHP                                 | `intelephense`                    |
| PHP                                 | `phpactor`                        |
| PHP                                 | `psalm`                           |
| Perl                                | `perlnavigator`                   |
| Powershell                          | `powershell_es`                   |
| Prisma                              | `prismals`                        |
| Puppet                              | `puppet`                          |
| PureScript                          | `purescriptls`                    |
| Python                              | `jedi_language_server`            |
| Python                              | `pyre`                            |
| Python                              | `pyright`                         |
| Python                              | `pylyzer`                         |
| Python                              | `sourcery`                        |
| Python [(docs)][pylsp]              | `pylsp`                           |
| Python                              | `ruff_lsp`                        |
| R                                   | `r_language_server`               |
| Raku                                | `raku_navigator`                  |
| ReScript                            | `rescriptls`                      |
| Reason                              | `reason_ls`                       |
| Robot Framework                     | `robotframework_ls`               |
| Rome                                | `rome`                            |
| Ruby                                | `ruby_ls`                         |
| Ruby                                | `solargraph`                      |
| Ruby                                | `sorbet`                          |
| Ruby                                | `standardrb`                      |
| Rust                                | `rust_analyzer`                   |
| SQL                                 | `sqlls`                           |
| SQL                                 | `sqls`                            |
| Salt                                | `salt_ls`                         |
| Shopify Theme Check                 | `theme_check`                     |
| Slint                               | `slint_lsp`                       |
| Smithy                              | `smithy_ls`                       |
| Solidity                            | `solang`                          |
| Solidity                            | `solc`                            |
| Solidity                            | `solidity`                        |
| Sphinx                              | `esbonio`                         |
| Stylelint                           | `stylelint_lsp`                   |
| Svelte                              | `svelte`                          |
| SystemVerilog                       | `svlangserver`                    |
| SystemVerilog                       | `svls`                            |
| SystemVerilog                       | `verible`                         |
| TOML                                | `taplo`                           |
| Tailwind CSS                        | `tailwindcss`                     |
| Teal                                | `teal_ls`                         |
| Terraform                           | `terraformls`                     |
| Terraform [(docs)][tflint]          | `tflint`                          |
| TypeScript                          | `tsserver`                        |
| TypeScript                          | `vtsls`                           |
| V                                   | `vls`                             |
| Vala                                | `vala_ls`                         |
| Veryl                               | `veryl_ls`                        |
| VimL                                | `vimls`                           |
| Visualforce                         | `visualforce_ls`                  |
| Vue                                 | `volar`                           |
| Vue                                 | `vuels`                           |
| WGSL                                | `wgsl_analyzer`                   |
| XML                                 | `lemminx`                         |
| YAML                                | `yamlls`                          |
| Zig                                 | `zls`                             |

[julials]: ./lua/mason-lspconfig/server_configurations/julials/README.md
[omnisharp]: ./lua/mason-lspconfig/server_configurations/omnisharp/README.md
[pylsp]: ./lua/mason-lspconfig/server_configurations/pylsp/README.md
[tflint]: ./lua/mason-lspconfig/server_configurations/tflint/README.md
