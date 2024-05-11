-- THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
-- stylua: ignore start
return {
  ["*"] = { "typos_lsp" },
  ["BUILD.bazel"] = { "starlark_rust" },
  OpenFOAM = { "foam_ls" },
  PKGBUILD = { "pkgbuild_language_server" },
  ada = { "als" },
  antlers = { "antlersls" },
  apexcode = { "apex_ls" },
  arduino = { "arduino_language_server" },
  asm = { "asm_lsp" },
  aspnetcorerazor = { "tailwindcss" },
  astro = { "astro", "biome", "emmet_ls", "eslint", "tailwindcss" },
  ["astro-markdown"] = { "tailwindcss" },
  automake = { "autotools_ls" },
  awk = { "awk_ls" },
  bean = { "beancount" },
  beancount = { "beancount" },
  bib = { "ltex", "texlab" },
  bicep = { "bicep" },
  blade = { "stimulus_ls", "tailwindcss" },
  brs = { "bright_script" },
  bsl = { "bsl_ls" },
  bzl = { "bzl", "starlark_rust" },
  c = { "ast_grep", "clangd", "harper_ls" },
  cairo = { "cairo_ls" },
  clar = { "clarity_lsp" },
  clarity = { "clarity_lsp" },
  clojure = { "clojure_lsp", "tailwindcss" },
  cmake = { "cmake", "neocmake" },
  cobol = { "cobol_ls" },
  comp = { "glsl_analyzer", "glslls" },
  config = { "autotools_ls" },
  context = { "ltex" },
  coq = { "coq_lsp" },
  cpp = { "ast_grep", "clangd", "harper_ls" },
  crystal = { "crystalline" },
  cs = { "csharp_ls", "omnisharp", "omnisharp_mono" },
  csharp = { "harper_ls" },
  css = { "ast_grep", "css_variables", "cssls", "emmet_language_server", "emmet_ls", "stylelint_lsp", "tailwindcss" },
  cucumber = { "cucumber_language_server" },
  cuda = { "clangd" },
  cue = { "dagger" },
  cypher = { "cypher_ls" },
  d = { "serve_d" },
  dart = { "ast_grep" },
  dhall = { "dhall_lsp_server" },
  ["django-html"] = { "tailwindcss" },
  dockerfile = { "dockerls" },
  dot = { "dotls" },
  drools = { "drools_lsp" },
  dune = { "ocamllsp" },
  earthfile = { "earthlyls" },
  edge = { "tailwindcss" },
  edn = { "clojure_lsp" },
  eelixir = { "elixirls", "lexical", "tailwindcss" },
  ejs = { "tailwindcss" },
  elixir = { "elixirls", "lexical", "tailwindcss" },
  elm = { "elmls" },
  erb = { "tailwindcss" },
  erg = { "erg_language_server" },
  erlang = { "elp", "erlangls" },
  eruby = { "emmet_language_server", "emmet_ls", "stimulus_ls", "tailwindcss" },
  fennel = { "fennel_language_server", "fennel_ls" },
  flux = { "flux_lsp" },
  foam = { "foam_ls" },
  fortran = { "fortls" },
  frag = { "glsl_analyzer", "glslls" },
  fsd = { "facility_language_server" },
  fsharp = { "fsautocomplete" },
  genie = { "vala_ls" },
  geom = { "glsl_analyzer", "glslls" },
  gitcommit = { "ltex" },
  glsl = { "glsl_analyzer", "glslls" },
  go = { "ast_grep", "golangci_lint_ls", "gopls", "harper_ls", "snyk_ls" },
  gohtml = { "tailwindcss" },
  gohtmltmpl = { "tailwindcss" },
  gomod = { "golangci_lint_ls", "gopls", "snyk_ls" },
  gotmpl = { "gopls" },
  gowork = { "gopls" },
  graphql = { "graphql" },
  groovy = { "gradle_ls", "groovyls" },
  haml = { "tailwindcss" },
  handlebars = { "ember", "glint", "tailwindcss" },
  haskell = { "hls" },
  haxe = { "haxe_language_server" },
  hbs = { "tailwindcss" },
  heex = { "elixirls", "lexical", "tailwindcss" },
  helm = { "helm_ls", "snyk_ls" },
  hoon = { "hoon_ls" },
  html = { "angularls", "antlersls", "ast_grep", "emmet_language_server", "emmet_ls", "html", "htmx", "ltex", "lwc_ls", "stimulus_ls", "tailwindcss", "unocss" },
  ["html-eex"] = { "tailwindcss" },
  ["html.handlebars"] = { "glint" },
  htmldjango = { "emmet_language_server", "emmet_ls", "tailwindcss" },
  jade = { "tailwindcss" },
  java = { "ast_grep", "java_language_server", "jdtls" },
  javascript = { "ast_grep", "biome", "cssmodules_ls", "denols", "dprint", "ember", "eslint", "glint", "harper_ls", "lwc_ls", "quick_lint_js", "rome", "snyk_ls", "sourcery", "stylelint_lsp", "tailwindcss", "tsserver", "vtsls" },
  ["javascript.glimmer"] = { "ember", "glint" },
  ["javascript.jsx"] = { "denols", "eslint", "tsserver", "vtsls" },
  javascriptreact = { "biome", "cssmodules_ls", "denols", "dprint", "emmet_language_server", "emmet_ls", "eslint", "graphql", "rome", "sourcery", "stylelint_lsp", "tailwindcss", "tsserver", "unocss", "vtsls" },
  jinja = { "jinja_lsp" },
  jq = { "jqls" },
  json = { "biome", "dprint", "jsonls", "rome", "snyk_ls", "spectral" },
  ["json.openapi"] = { "vacuum" },
  jsonc = { "biome", "dprint", "jsonls" },
  jsonnet = { "jsonnet_ls" },
  julia = { "julials" },
  kotlin = { "ast_grep", "kotlin_language_server" },
  leaf = { "tailwindcss" },
  less = { "css_variables", "cssls", "emmet_language_server", "emmet_ls", "stylelint_lsp", "tailwindcss" },
  lhaskell = { "hls" },
  libsonnet = { "jsonnet_ls" },
  liquid = { "tailwindcss", "theme_check" },
  llw = { "lelwel_ls" },
  lua = { "ast_grep", "harper_ls", "lua_ls" },
  luau = { "luau_lsp" },
  mail = { "ltex" },
  make = { "autotools_ls" },
  markdown = { "dprint", "grammarly", "harper_ls", "ltex", "markdown_oxide", "marksman", "prosemd_lsp", "remark_ls", "tailwindcss", "vale_ls", "zk" },
  ["markdown.mdx"] = { "marksman", "mdx_analyzer" },
  matlab = { "matlab_ls" },
  mdx = { "tailwindcss" },
  menhir = { "ocamllsp" },
  meson = { "mesonlsp", "swift_mesonls" },
  ["metamath-zero"] = { "mm0_ls" },
  motoko = { "motoko_lsp" },
  move = { "move_analyzer" },
  mustache = { "tailwindcss" },
  muttrc = { "mutt_ls" },
  mysql = { "sqlls", "sqls" },
  ncl = { "nickel_ls" },
  neomuttrc = { "mutt_ls" },
  nickel = { "nickel_ls" },
  nim = { "nim_langserver", "nimls" },
  nix = { "nil_ls", "rnix" },
  njk = { "tailwindcss" },
  nunjucks = { "tailwindcss" },
  objc = { "clangd" },
  objcpp = { "clangd" },
  ocaml = { "ocamllsp" },
  ocamlinterface = { "ocamllsp" },
  ocamllex = { "ocamllsp" },
  odin = { "ols" },
  opencl = { "opencl_ls" },
  openscad = { "openscad_lsp" },
  org = { "ltex" },
  os = { "bsl_ls" },
  p8 = { "pico8_ls" },
  pandoc = { "ltex" },
  perl = { "perlnavigator" },
  pest = { "pest_ls" },
  php = { "intelephense", "phpactor", "psalm", "stimulus_ls", "tailwindcss" },
  plaintex = { "ltex", "texlab" },
  postcss = { "tailwindcss" },
  prisma = { "prismals" },
  proto = { "bufls", "clangd" },
  ps1 = { "powershell_es" },
  pug = { "emmet_language_server", "emmet_ls" },
  puppet = { "puppet" },
  purescript = { "purescriptls" },
  python = { "ast_grep", "basedpyright", "dprint", "harper_ls", "jedi_language_server", "pylsp", "pylyzer", "pyre", "pyright", "ruff", "ruff_lsp", "snyk_ls", "sourcery" },
  ql = { "codeqlls" },
  quarto = { "ltex" },
  r = { "r_language_server" },
  raku = { "raku_navigator" },
  razor = { "tailwindcss" },
  reason = { "ocamllsp", "reason_ls", "tailwindcss" },
  rego = { "regols" },
  requirements = { "snyk_ls" },
  rescript = { "rescriptls", "tailwindcss", "unocss" },
  rmd = { "ltex", "r_language_server" },
  rnoweb = { "ltex" },
  robot = { "robotframework_ls" },
  roslyn = { "dprint" },
  rst = { "esbonio", "ltex" },
  ruby = { "harper_ls", "rubocop", "ruby_lsp", "solargraph", "sorbet", "standardrb", "stimulus_ls" },
  rust = { "ast_grep", "dprint", "harper_ls", "rust_analyzer" },
  sass = { "emmet_language_server", "emmet_ls", "somesass_ls", "tailwindcss" },
  scss = { "css_variables", "cssls", "emmet_language_server", "emmet_ls", "somesass_ls", "stylelint_lsp", "tailwindcss" },
  sh = { "bashls" },
  slim = { "tailwindcss" },
  slint = { "slint_lsp" },
  sls = { "salt_ls" },
  smithy = { "smithy_ls" },
  sml = { "millet" },
  solidity = { "solang", "solc", "solidity", "solidity_ls", "solidity_ls_nomicfoundation" },
  sql = { "sqlls", "sqls" },
  star = { "starlark_rust" },
  stylus = { "tailwindcss" },
  sugarss = { "stylelint_lsp", "tailwindcss" },
  surface = { "elixirls", "lexical" },
  svelte = { "biome", "emmet_ls", "eslint", "svelte", "tailwindcss", "unocss" },
  svg = { "lemminx" },
  swift = { "harper_ls" },
  systemverilog = { "hdl_checker", "svlangserver", "svls", "verible" },
  teal = { "teal_ls" },
  templ = { "html", "htmx", "tailwindcss", "templ" },
  terraform = { "terraformls", "tflint" },
  ["terraform-vars"] = { "terraformls" },
  tesc = { "glsl_analyzer", "glslls" },
  tese = { "glsl_analyzer", "glslls" },
  tex = { "ltex", "texlab" },
  text = { "ltex", "vale_ls" },
  thrift = { "thriftls" },
  toml = { "dprint", "harper_ls", "taplo" },
  twig = { "tailwindcss", "twiggy_language_server" },
  typescript = { "angularls", "ast_grep", "biome", "cssmodules_ls", "denols", "dprint", "ember", "eslint", "glint", "harper_ls", "quick_lint_js", "rome", "snyk_ls", "sourcery", "stylelint_lsp", "tailwindcss", "tsserver", "vtsls" },
  ["typescript.glimmer"] = { "ember", "glint" },
  ["typescript.tsx"] = { "angularls", "biome", "denols", "eslint", "rome", "tsserver", "vtsls" },
  typescriptreact = { "angularls", "biome", "cssmodules_ls", "denols", "dprint", "emmet_language_server", "emmet_ls", "eslint", "graphql", "harper_ls", "rome", "sourcery", "stylelint_lsp", "tailwindcss", "tsserver", "unocss", "vtsls" },
  typst = { "tinymist", "typst_lsp" },
  v = { "v_analyzer", "vls" },
  vala = { "vala_ls" },
  vb = { "omnisharp", "omnisharp_mono" },
  verilog = { "hdl_checker", "svlangserver", "svls", "verible" },
  vert = { "glsl_analyzer", "glslls" },
  veryl = { "veryl_ls" },
  vhd = { "vhdl_ls" },
  vhdl = { "hdl_checker", "vhdl_ls" },
  vim = { "vimls" },
  visualforce = { "visualforce_ls" },
  vlang = { "vls" },
  vmasm = { "asm_lsp" },
  vsh = { "v_analyzer" },
  vue = { "biome", "emmet_ls", "eslint", "stylelint_lsp", "tailwindcss", "unocss", "volar", "vuels" },
  vv = { "v_analyzer" },
  wgsl = { "wgsl_analyzer" },
  wxss = { "stylelint_lsp" },
  xhtml = { "ltex" },
  xml = { "lemminx" },
  xsd = { "lemminx" },
  xsl = { "lemminx" },
  xslt = { "lemminx" },
  yaml = { "azure_pipelines_ls", "hydra_lsp", "snyk_ls", "spectral", "yamlls" },
  ["yaml.ansible"] = { "ansiblels" },
  ["yaml.docker-compose"] = { "docker_compose_language_service", "yamlls" },
  ["yaml.gitlab"] = { "gitlab_ci_ls", "yamlls" },
  ["yaml.openapi"] = { "vacuum" },
  yml = { "spectral" },
  zig = { "zls" },
  zir = { "zls" }
}