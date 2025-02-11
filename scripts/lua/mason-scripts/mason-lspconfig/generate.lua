require "mason-lspconfig.server_config_extensions"()
local Optional = require "mason-core.optional"

local _ = require "mason-core.functional"
local a = require "mason-core.async"
local fs = require "mason-core.fs"
local lspconfig = require "lspconfig"
local lspconfig_server_mapping = require "mason-lspconfig.mappings.server"
local path = require "mason-core.path"
local script_utils = require "mason-scripts.utils"

local DOCS_DIR = "doc"
local MASON_LSPCONFIG_DIR = path.concat { "lua", "mason-lspconfig" }

require("mason").setup()
require("mason-registry").refresh()

---@async
local function create_lspconfig_filetype_map()
    local filetype_map = {}

    for _, server_name in ipairs(_.keys(lspconfig_server_mapping.lspconfig_to_package)) do
        local config = assert(
            lspconfig[server_name] and lspconfig[server_name].document_config,
            ("Failed to get config for %s"):format(server_name)
        )
        for _, filetype in ipairs(config.default_config.filetypes or {}) do
            if not filetype_map[filetype] then
                filetype_map[filetype] = {}
            end
            table.insert(filetype_map[filetype], server_name)
            table.sort(filetype_map[filetype])
        end
    end

    script_utils.write_file(
        path.concat { MASON_LSPCONFIG_DIR, "mappings", "filetype.lua" },
        "return " .. vim.inspect(filetype_map),
        "w"
    )
end

---@async
local function ensure_valid_package_name_translations()
    local server_mappings = require "mason-lspconfig.mappings.server"
    local registry = require "mason-registry"

    for lspconfig_server, mason_package in pairs(server_mappings.lspconfig_to_package) do
        local server_config = lspconfig[lspconfig_server]
        local mason_ok, pkg = pcall(registry.get_package, mason_package)
        assert(server_config ~= nil, lspconfig_server .. " is not a valid lspconfig server name.")
        assert(mason_ok and pkg ~= nil, mason_package .. " is not a valid Mason package name.")
    end
end

local get_lspconfig_url = _.format "https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#%s"

local get_server_mappings = _.compose(
    _.filter_map(function(pair)
        local lspconfig_name, mason_name =
            assert(pair[1], "missing lspconfig name"), assert(pair[2], "missing mason name")
        if not pcall(require, "lspconfig.configs." .. lspconfig_name) then
            return Optional.empty()
        end
        local mason_url = ("https://mason-registry.dev/registry/list#%s"):format(mason_name)
        return Optional.of {
            lspconfig_name = lspconfig_name,
            mason_name = mason_name,
            lspconfig_url = get_lspconfig_url(lspconfig_name),
            mason_url = mason_url,
        }
    end),
    _.sort_by(_.head),
    _.to_pairs
)

---@async
local function create_server_mapping_docs()
    local server_mappings = get_server_mappings(require("mason-lspconfig.mappings.server").lspconfig_to_package)

    do
        local markdown_header = {
            "| lspconfig server name | mason.nvim package name |",
            "| --------------------- | ----------------------- |",
        }

        local markdown_table = _.map(function(map)
            return string.format(
                "| [%s](%s) | [%s](%s) |",
                map.lspconfig_name,
                map.lspconfig_url,
                map.mason_name,
                map.mason_url
            )
        end, server_mappings)

        local markdown = _.join("\n", _.concat(markdown_header, markdown_table))
        script_utils.write_file(path.concat { DOCS_DIR, "server-mapping.md" }, markdown)
    end

    do
        local vimdoc_header = {
            "*mason-lspconfig-mapping.txt*",
            "",
            "==============================================================================",
            "SERVER MAPPINGS                                   *mason-lspconfig-server-map*",
            "",
        }

        local vimdoc_footer = {
            "",
            "vim:tw=78:ft=help:norl:expandtab:sw=4",
        }

        local col_width = _.apply(math.max, _.map(_.compose(_.length, _.prop "mason_name"), server_mappings)) + 2

        local vimdoc_table = _.concat(
            {
                "`Mason name`" .. (" "):rep(col_width - #"Mason name") .. "`lspconfig name`",
            },
            _.map(function(map)
                return ("%s%s%s"):format(map.mason_name, (" "):rep(col_width - #map.mason_name), map.lspconfig_name)
            end, server_mappings)
        )

        local concat = _.reduce(_.concat, {})

        local vimdoc = _.join("\n", concat { vimdoc_header, vimdoc_table, vimdoc_footer })
        script_utils.write_file(path.concat { DOCS_DIR, "mason-lspconfig-mapping.txt" }, vimdoc)
    end
end

local find_index = _.curryN(function(predicate, list)
    for i, item in ipairs(list) do
        if predicate(item) then
            return i
        end
    end
    return -1
end, 2)

---@async
local function update_available_lsp_servers()
    local readme_path = "README.md"
    local readme_contents = fs.sync.read_file(readme_path)
    local readme_lines = _.split("\n", readme_contents)

    local start = find_index(_.equals "<!-- available-lsp-servers:start -->", readme_lines) + 1
    local stop = find_index(_.equals "<!-- available-lsp-servers:end -->", readme_lines) - 1

    for i = stop, start, -1 do
        table.remove(readme_lines, i)
    end

    local server_mappings = require("mason-lspconfig.mappings.server").lspconfig_to_package
    local registry = require "mason-registry"

    ---@type {languages: string[], name: string}[]
    local servers = {}

    for lspconfig_name, mason_name in pairs(server_mappings) do
        local pkg = registry.get_package(mason_name)
        table.insert(servers, {
            languages = pkg.spec.languages,
            name = lspconfig_name,
        })
    end

    local servers_markdown_list = _.compose(
        _.map(function(entry)
            local server_docs = path.concat { MASON_LSPCONFIG_DIR, "server_configurations", entry.server, "README.md" }
            if fs.sync.file_exists(server_docs) then
                return ("| %s ([docs](%s)) | [`%s`](%s) |"):format(
                    entry.language,
                    server_docs,
                    entry.server,
                    get_lspconfig_url(entry.server)
                )
            else
                return ("| %s | [`%s`](%s) |"):format(entry.language, entry.server, get_lspconfig_url(entry.server))
            end
        end),
        _.sort_by(function(entry)
            if entry.language == "-" then
                -- brother eww
                return "zzzz" .. (entry.language .. entry.server):lower()
            else
                return (entry.language .. entry.server):lower()
            end
        end),
        function(tbl)
            return vim.iter(tbl):flatten():totable()
        end,
        _.map(function(server)
            if #server.languages == 0 then
                return {
                    {
                        server = server.name,
                        language = "-",
                    },
                }
            else
                return _.map(function(language)
                    return {
                        server = server.name,
                        language = language,
                    }
                end, server.languages)
            end
        end)
    )(servers)

    for i = #servers_markdown_list, 1, -1 do
        table.insert(readme_lines, start, servers_markdown_list[i])
    end

    for _, line in
        ipairs(_.reverse {
            "| Language | Server name |",
            "| --- | --- |",
        })
    do
        table.insert(readme_lines, start, line)
    end

    fs.sync.write_file(readme_path, _.join("\n", readme_lines))
end

a.run_blocking(function()
    a.wait_all {
        create_lspconfig_filetype_map,
        ensure_valid_package_name_translations,
        create_server_mapping_docs,
        update_available_lsp_servers,
    }
end)
