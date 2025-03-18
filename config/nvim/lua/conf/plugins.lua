vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'nvim-lua/plenary.nvim'
  Plug 'Hoffs/omnisharp-extended-lsp.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'mbbill/undotree'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'mfussenegger/nvim-lint'
  Plug 'mhartington/formatter.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'lervag/vimtex'
  Plug 'tpope/vim-obsession'

  call plug#end()
]]
