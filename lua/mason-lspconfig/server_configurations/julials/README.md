# julials

## Configuring the Julia Environment

The Julia Environment will be identified in the following order:

1) user configuration (`lspconfig.julials.setup { julia_env_path = "/my/env" }`)
2) if the `Project.toml` & `Manifest.toml` (or `JuliaProject.toml` & `JuliaManifest.toml`) files exists in the current project working directory, the current project working directory is used as the environment
3) the result of `Pkg.Types.Context().env.project_file`

## Configuring symbol cache

By default, the language server is configured to download symbol caches from Julia's symbol server. To disable this, set
`symbol_cache_download` to `false`:

```lua
lspconfig.julials.setup {
    symbol_cache_download = false,
}
```

To change the symbol server URL, set the `symbol_server` configuration:

```lua
lspconfig.julials.setup {
    symbol_server = "https://symbol-server",
}
```
