local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

local lsps = {
    ts_ls        = {},
    eslint       = {},
    ruff         = {},
    texlab       = {},
    omnisharp    = {},
    ty           = {},
    basedpyright = {},
    tinymist     = function()
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
    bashls       = {},
    cssls        = {},
    lua_ls       = function()
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
            vim.lsp.inline_completion.enable(true)
        end
    end,
}

for name, override in pairs(lsps) do
    local cfg = type(override) == "function" and override() or (override or {})
    cfg = merge(defaults, cfg)
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
end

vim.o.autocomplete = true
vim.lsp.inlay_hint.enable(true)


-- enables codelens  (inline actionable hints like Run test or References)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method 'textDocument/codeLens' then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
        end
    end,
})
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens" })


-- highlight references under current cursor
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        if client and client:supports_method('textDocument/documentHighlight') then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})


-- Automatic signature Help
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method('textDocument/signatureHelp') then
            -- This triggers signature help when you type a trigger character (like '(' or ',')
            vim.api.nvim_create_autocmd('InsertCharPre', {
                buffer = args.buf,
                callback = function()
                    if vim.v.char == '(' or vim.v.char == ',' then
                        vim.schedule(vim.lsp.buf.signature_help)
                    end
                end,
            })
        end
    end,
})


-- Simple native breadcrumbs
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(_)
        vim.opt_local.winbar = "%{%v:lua.vim.lsp.status()%} %f %m"
    end
})
