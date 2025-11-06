vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  Plug 'mbbill/undotree'

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'


  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'mfussenegger/nvim-dap'
  Plug 'mfussenegger/nvim-dap-python'
  Plug 'nvim-neotest/nvim-nio'
  Plug 'rcarriga/nvim-dap-ui'

  Plug 'stevearc/conform.nvim'

  Plug 'ggml-org/llama.vim'

  Plug 'https://gitlab.com/schrieveslaach/sonarlint.nvim'

  Plug 'nvim-orgmode/orgmode'

  call plug#end()
]]
