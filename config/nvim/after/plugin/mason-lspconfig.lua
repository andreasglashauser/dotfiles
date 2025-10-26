require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { 
     "ts_ls"
    , "eslint"
    , "basedpyright"
    , "ruff"
    , "omnisharp"
    , "texlab"
  },
}
