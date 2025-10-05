-- Minimal OmniSharp setup (installed via vim-plug, not Mason)
-- Keep this lean: just ensure the server gets downloaded and works with modern .NET.

-- Prefer the modern .NET (net6) build of the server
vim.g.OmniSharp_server_use_net6 = 1

-- Auto-download the OmniSharp-roslyn server if it isn't present
-- (If unsupported, this is harmless.)
vim.g.OmniSharp_server_download = 1

-- Enable basic omni-completion for C# buffers so <C-x><C-o> works out of the box
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'csx', 'csharp' },
  callback = function(args)
    vim.bo.omnifunc = 'OmniSharp#Complete'

    -- Use gd to jump to definition in C# buffers
    vim.keymap.set('n', 'gd', '<cmd>OmniSharpGotoDefinition<CR>', {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Match Python/LSP-style keymaps for consistency
    -- Hover/type info
    vim.keymap.set('n', 'K', '<cmd>OmniSharpTypeLookup<CR>', {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Rename symbol
    vim.keymap.set('n', '<leader>rn', '<cmd>OmniSharpRename<CR>', {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Code actions
    vim.keymap.set('n', '<leader>ca', '<cmd>OmniSharpGetCodeActions<CR>', {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Format buffer
    vim.keymap.set('n', '<leader>f', '<cmd>OmniSharpCodeFormat<CR>', {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Show diagnostics for C# using OmniSharp's code check.
    -- This runs a check and opens the Quickfix list with warnings/errors.
    vim.keymap.set('n', '<leader>e', function()
      vim.cmd('silent! OmniSharpCodeCheck')
      local qf_info = vim.fn.getqflist({ size = 0 })
      if qf_info and qf_info.size and qf_info.size > 0 then
        vim.cmd('copen')
      else
        vim.notify('No C# diagnostics found', vim.log.levels.INFO)
      end
    end, {
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Optionally, re-run checks on save to keep diagnostics fresh
    vim.api.nvim_create_autocmd('BufWritePost', {
      buffer = args.buf,
      callback = function()
        vim.cmd('silent! OmniSharpCodeCheck')
      end,
      desc = 'OmniSharp: refresh diagnostics on save',
    })
  end,
})
