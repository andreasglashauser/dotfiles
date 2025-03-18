  local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig =  require('lspconfig')

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lspconfig.clangd.setup({
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern(".clangd", ".git", "compile_commands.json", "compile_flags.txt"),
    single_file_support = true,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = on_attach,
})

local on_attach_csharp = function(client, bufnr)
  if client.name == "omnisharp" then
    vim.keymap.set('n', 'gd', "<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })<cr>", { noremap = true, buffer = bufnr })
    vim.keymap.set('n', 'gr', "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>", { noremap = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>D', "<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>", { noremap = true, buffer = bufnr })
    vim.keymap.set('n', 'gi', "<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>", { noremap = true, buffer = bufnr })
  end
end

lspconfig.omnisharp.setup({
  cmd = { "/usr/sbin/dotnet", "/home/andreasg/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  on_attach = on_attach_csharp,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
    ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
    ["textDocument/references"] = require('omnisharp_extended').references_handler,
    ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
  },

  filetypes = { "*.sln", "*.csproj", "*.git", "*.cs" },
  settings = {
    FormattingOptions = {
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      EnableEditorConfigSupport = true,
      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      OrganizeImports = nil,
    },
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = nil,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = nil,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      AnalyzeOpenDocumentsOnly = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = true,
    },
  },
})
