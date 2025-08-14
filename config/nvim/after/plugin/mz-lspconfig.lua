local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig =  require('lspconfig')

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

    -- Show diagnostics on cursor hold
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end
    })
    
    -- Format on save
--    if client.server_capabilities.documentFormattingProvider then
--        vim.api.nvim_create_autocmd("BufWritePre", {
--            buffer = bufnr,
--            callback = function()
--                vim.lsp.buf.format({ timeout_ms = 2000 })
--            end
--        })
--    end
end


lspconfig.basedpyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
}

lspconfig.ruff.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})


lspconfig.eslint.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    -- Allow using globally installed eslint when a local one is missing
    cmd = { "bash", "-lc", "NODE_PATH=$(npm root -g) vscode-eslint-language-server --stdio" },
    settings = {
        workingDirectories = {
            { mode = "auto" }
        }
    }
}

lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

