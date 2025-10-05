vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  Plug 'mbbill/undotree'

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'


  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'mfussenegger/nvim-dap'
  Plug 'mfussenegger/nvim-dap-python'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'nvim-neotest/nvim-nio'

  " C# support (OmniSharp via vim-plug, not Mason)
  Plug 'OmniSharp/omnisharp-vim', { 'do': ':OmniSharpInstall' }

  call plug#end()
]]
