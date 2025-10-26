require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    python = { "ruff_format" },
    bash = { "shfmt" },
  },
})
