-- THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
-- stylua: ignore start
return {
  ["BUILD.bazel"] = { "starlark_rust" },
  OpenFOAM = { "foam_ls" },
  PKGBUILD = { "pkgbuild_language_server" },
  antlers = { "antlersls" },
  apexcode = { "apex_ls" },
  arduino = { "arduino_language_server" },
  asm = { "asm_lsp" },
  ahk = { "autohotkey_lsp" },
  ah2 = { "autohotkey_lsp" },
  autohotkey = { "autohotkey_lsp" },
  aspnetcorerazor = { "htmx", "tailwindcss" },
  astro = { "astro", "biome", "emmet_ls", "eslint", "htmx", "tailwindcss", "unocss" },
  ["astro-markdown"] = { "htmx", "tailwindcss" },
  automake = { "autotools_ls" },
  awk = { "awk_ls" },
  bash = { "bashls" },
  bean = { "beancount" },
  beancount = { "beancount" },
  bib = { "ltex", "texlab" },
  bicep = { "bicep" },
  blade = { "htmx", "stimulus_ls", "tailwindcss" },
  brs = { "bright_script" },
  bsl = { "bsl_ls" },
  bzl = { "bzl", "starlark_rust", "starpls" },
  c = { "ast_grep", "clangd", "harper_ls" },
  cairo = { "cairo_ls" },
  clar = { "clarity_lsp" },
  clarity = { "clarity_lsp" },
  clojure = { "clojure_lsp", "htmx", "tailwindcss" },
  cmake = { "cmake", "neocmake" },
  cobol = { "cobol_ls" },
  comp = { "glsl_analyzer", "glslls" },
  config = { "autotools_ls" },
  context = { "ltex" },
  coq = { "coq_lsp" },
  cpp = { "ast_grep", "clangd", "harper_ls" },
  crystal = { "crystalline" },
  cs = { "csharp_ls", "harper_ls", "omnisharp", "omnisharp_mono" },
  css = { "ast_grep", "biome", "css_variables", "cssls", "emmet_language_server", "emmet_ls", "stylelint_lsp", "tailwindcss", "unocss" },
  cucumber = { "cucumber_language_server" },
  cuda = { "clangd" },
  cue = { "dagger" },
  cypher = { "cypher_ls" },
  d = { "serve_d" },
  dart = { "ast_grep" },
  dhall = { "dhall_lsp_server" },
  ["django-html"] = { "htmx", "tailwindcss" },
  dockerfile = { "dockerls" },
  dot = { "dotls" },
  drools = { "drools_lsp" },
  dts = { "ginko_ls" },
  dune = { "ocamllsp" },
  earthfile = { "earthlyls" },
  edge = { "htmx", "tailwindcss" },
  edn = { "clojure_lsp" },
  eelixir = { "elixirls", "htmx", "lexical", "nextls", "tailwindcss" },
  ejs = { "htmx", "tailwindcss", "unocss" },
  elixir = { "elixirls", "htmx", "lexical", "nextls", "tailwindcss" },
  elm = { "elmls" },
  erb = { "htmx", "tailwindcss", "unocss" },
  erg = { "erg_language_server" },
  erlang = { "elp", "erlangls" },
  eruby = { "emmet_language_server", "emmet_ls", "htmx", "ruby_lsp", "steep", "stimulus_ls", "tailwindcss" },
  fennel = { "fennel_language_server", "fennel_ls" },
  flux = { "flux_lsp" },
  foam = { "foam_ls" },
  fortran = { "fortls" },
  frag = { "glsl_analyzer", "glslls" },
  fsd = { "facility_language_server" },
  fsharp = { "fsautocomplete" },
  genie = { "vala_ls" },
  geom = { "glsl_analyzer", "glslls" },
  gitcommit = { "harper_ls", "ltex" },
  glsl = { "glsl_analyzer", "glslls" },
  go = { "ast_grep", "golangci_lint_ls", "gopls", "harper_ls", "snyk_ls" },
  gohtml = { "htmx", "tailwindcss" },
  gohtmltmpl = { "htmx", "tailwindcss" },
  gomod = { "golangci_lint_ls", "gopls", "snyk_ls" },
  gotmpl = { "gopls" },
  gowork = { "gopls" },
  graphql = { "biome", "dprint", "graphql" },
  groovy = { "gradle_ls", "groovyls" },
  haml = { "htmx", "tailwindcss", "unocss" },
  handlebars = { "ember", "glint", "htmx", "tailwindcss" },
  haskell = { "hls" },
  haxe = { "haxe_language_server" },
  hbs = { "htmx", "tailwindcss", "unocss" },
  heex = { "elixirls", "htmx", "lexical", "nextls", "tailwindcss" },
  helm = { "helm_ls", "snyk_ls" },
  hoon = { "hoon_ls" },
  html = { "angularls", "antlersls", "ast_grep", "emmet_language_server", "emmet_ls", "harper_ls", "html", "htmx", "ltex", "lwc_ls", "stimulus_ls", "tailwindcss", "unocss" },
  ["html-eex"] = { "htmx", "tailwindcss" },
  ["html.handlebars"] = { "glint" },
  htmlangular = { "angularls", "emmet_language_server", "emmet_ls", "htmx", "tailwindcss" },
  htmldjango = { "emmet_language_server", "emmet_ls", "htmx", "tailwindcss" },
  hyprlang = { "hyprls" },
  jade = { "htmx", "tailwindcss" },
  java = { "ast_grep", "harper_ls", "java_language_server", "jdtls" },
  javascript = { "ast_grep", "biome", "cssmodules_ls", "denols", "dprint", "ember", "eslint", "glint", "harper_ls", "htmx", "lwc_ls", "quick_lint_js", "rome", "snyk_ls", "sourcery", "tailwindcss", "ts_ls", "unocss", "vtsls" },
  ["javascript.glimmer"] = { "ember", "glint" },
  ["javascript.jsx"] = { "denols", "eslint", "ts_ls", "vtsls" },
  javascriptreact = { "biome", "cssmodules_ls", "denols", "dprint", "emmet_language_server", "emmet_ls", "eslint", "graphql", "htmx", "rome", "sourcery", "tailwindcss", "ts_ls", "unocss", "vtsls" },
  jinja = { "jinja_lsp" },
  jq = { "jqls" },
  json = { "biome", "dprint", "jsonls", "rome", "snyk_ls", "spectral" },
  ["json.openapi"] = { "vacuum" },
  jsonc = { "biome", "dprint", "jsonls" },
  jsonnet = { "jsonnet_ls" },
  julia = { "julials" },
  kcl = { "kcl" },
  kotlin = { "ast_grep", "kotlin_language_server" },
  leaf = { "htmx", "tailwindcss" },
  less = { "css_variables", "cssls", "emmet_language_server", "emmet_ls", "stylelint_lsp", "tailwindcss", "unocss" },
  lhaskell = { "hls" },
  libsonnet = { "jsonnet_ls" },
  liquid = { "htmx", "shopify_theme_ls", "tailwindcss", "theme_check" },
  llw = { "lelwel_ls" },
  lua = { "ast_grep", "harper_ls", "lua_ls" },
  luau = { "luau_lsp" },
  mail = { "ltex" },
  make = { "autotools_ls" },
  markdown = { "dprint", "grammarly", "harper_ls", "htmx", "ltex", "markdown_oxide", "marksman", "prosemd_lsp", "remark_ls", "tailwindcss", "unocss", "vale_ls", "zk" },
  ["markdown.mdx"] = { "marksman", "mdx_analyzer" },
  matlab = { "matlab_ls" },
  mdx = { "htmx", "tailwindcss" },
  menhir = { "ocamllsp" },
  meson = { "mesonlsp", "swift_mesonls" },
  ["metamath-zero"] = { "mm0_ls" },
  motoko = { "motoko_lsp" },
  move = { "move_analyzer" },
  mustache = { "htmx", "tailwindcss" },
  muttrc = { "mutt_ls" },
  mysql = { "sqlls", "sqls" },
  ncl = { "nickel_ls" },
  neomuttrc = { "mutt_ls" },
  nginx = { "nginx_language_server" },
  nickel = { "nickel_ls" },
  nim = { "nim_langserver", "nimls" },
  nix = { "harper_ls", "nil_ls", "rnix" },
  njk = { "htmx", "tailwindcss" },
  nunjucks = { "htmx", "tailwindcss" },
  objc = { "clangd" },
  objcpp = { "clangd" },
  ocaml = { "ocamllsp" },
  ocamlinterface = { "ocamllsp" },
  ocamllex = { "ocamllsp" },
  odin = { "ols" },
  opencl = { "opencl_ls" },
  openscad = { "openscad_lsp" },
  org = { "ltex", "textlsp" },
  os = { "bsl_ls" },
  p8 = { "pico8_ls" },
  pandoc = { "ltex" },
  perl = { "perlnavigator" },
  pest = { "pest_ls" },
  php = { "htmx", "intelephense", "phpactor", "psalm", "stimulus_ls", "tailwindcss", "unocss" },
  plaintex = { "ltex", "texlab" },
  postcss = { "tailwindcss", "unocss" },
  prisma = { "prismals" },
  proto = { "buf_ls", "clangd", "pbls" },
  ps1 = { "powershell_es" },
  pug = { "emmet_language_server", "emmet_ls" },
  puppet = { "puppet" },
  purescript = { "purescriptls" },
  python = { "ast_grep", "basedpyright", "dprint", "harper_ls", "jedi_language_server", "pylsp", "pylyzer", "pyre", "pyright", "ruff", "snyk_ls", "sourcery" },
  ql = { "codeqlls" },
  quarto = { "ltex" },
  r = { "r_language_server" },
  raku = { "raku_navigator" },
  razor = { "htmx", "tailwindcss" },
  reason = { "htmx", "ocamllsp", "reason_ls", "tailwindcss" },
  rego = { "regal", "regols" },
  requirements = { "snyk_ls" },
  rescript = { "htmx", "rescriptls", "tailwindcss", "unocss" },
  rmd = { "ltex", "r_language_server" },
  rnoweb = { "ltex" },
  robot = { "robotframework_ls" },
  roslyn = { "dprint" },
  rst = { "esbonio", "ltex", "vale_ls" },
  ruby = { "harper_ls", "rubocop", "ruby_lsp", "solargraph", "sorbet", "standardrb", "steep", "stimulus_ls" },
  rust = { "ast_grep", "dprint", "harper_ls", "rust_analyzer", "unocss" },
  sass = { "emmet_language_server", "emmet_ls", "somesass_ls", "tailwindcss", "unocss" },
  scss = { "css_variables", "cssls", "emmet_language_server", "emmet_ls", "somesass_ls", "stylelint_lsp", "tailwindcss", "unocss" },
  sh = { "bashls" },
  slim = { "htmx", "tailwindcss" },
  slint = { "slint_lsp" },
  sls = { "salt_ls" },
  smithy = { "smithy_ls" },
  sml = { "millet" },
  solidity = { "solang", "solc", "solidity", "solidity_ls", "solidity_ls_nomicfoundation" },
  sql = { "sqlls", "sqls" },
  ss = { "snakeskin_ls" },
  star = { "starlark_rust" },
  stylus = { "tailwindcss", "unocss" },
  sugarss = { "stylelint_lsp", "tailwindcss" },
  surface = { "elixirls", "lexical", "nextls" },
  svelte = { "biome", "emmet_ls", "eslint", "htmx", "svelte", "tailwindcss", "unocss" },
  svg = { "lemminx" },
  swift = { "harper_ls" },
  systemverilog = { "hdl_checker", "svlangserver", "svls", "verible" },
  teal = { "teal_ls" },
  templ = { "html", "htmx", "tailwindcss", "templ" },
  terraform = { "snyk_ls", "terraformls", "tflint" },
  ["terraform-vars"] = { "snyk_ls", "terraformls" },
  tesc = { "glsl_analyzer", "glslls" },
  tese = { "glsl_analyzer", "glslls" },
  tex = { "ltex", "texlab", "textlsp", "vale_ls" },
  text = { "ltex", "textlsp", "vale_ls" },
  thrift = { "thriftls" },
  toml = { "dprint", "harper_ls", "taplo" },
  twig = { "htmx", "tailwindcss", "twiggy_language_server" },
  typescript = { "angularls", "ast_grep", "biome", "cssmodules_ls", "denols", "dprint", "ember", "eslint", "glint", "harper_ls", "htmx", "quick_lint_js", "rome", "snyk_ls", "sourcery", "tailwindcss", "ts_ls", "unocss", "vtsls" },
  ["typescript.glimmer"] = { "ember", "glint" },
  ["typescript.tsx"] = { "angularls", "biome", "denols", "eslint", "rome", "ts_ls", "vtsls" },
  typescriptreact = { "angularls", "biome", "cssmodules_ls", "denols", "dprint", "emmet_language_server", "emmet_ls", "eslint", "graphql", "harper_ls", "htmx", "rome", "sourcery", "tailwindcss", "ts_ls", "unocss", "vtsls" },
  typespec = { "tsp_server" },
  typst = { "tinymist" },
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
  vue = { "biome", "emmet_ls", "eslint", "htmx", "stylelint_lsp", "tailwindcss", "unocss", "volar", "vuels" },
  ["vue-html"] = { "unocss" },
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