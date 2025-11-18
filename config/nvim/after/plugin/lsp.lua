local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

local lsps = {
    ts_ls     = {},
    eslint    = {},
    ruff      = {},
    texlab    = {},
    omnisharp = {},
    tinymist  = function()
        return {
            cmd = { "tinymist" },
            filetypes = { "typst" },
            settings = {
                formatterMode = "typstyle",
                exportPdf = "onType",
                semanticTokens = "disable",
                outputPath = '$root/target/',
            }
        }
    end,
    bashls    = {},
    cssls     = {},
    lua_ls    = function()
        return {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }
    end,
}

local function merge(a, b)
    return vim.tbl_deep_extend("force", a or {}, b or {})
end

local defaults = {
    capabilities = cmp_caps,
    on_attach = function(client, bufnr)
        if client:supports_method('textDocument/documentColor') then
            -- options: background (default), foreground, virtual (VS Code style)
            vim.lsp.document_color.enable(true, bufnr, { style = 'background' })
        end
        if client:supports_method('textDocument/inlineCompletion') then
            -- I think currently only copilot language server (https://www.npmjs.com/package/@github/copilot-language-server)
            --  uses this, but in the future there will be sure more supported lsp's
            vim.lsp.document_color.enable(true)
        end
    end,
}

for name, override in pairs(lsps) do
    local cfg = type(override) == "function" and override() or (override or {})
    cfg = merge(defaults, cfg)
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
end

vim.lsp.inline_completion.enable(true)
