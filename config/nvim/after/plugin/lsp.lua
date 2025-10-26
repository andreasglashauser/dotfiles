local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

local lsps = {
    { "ts_ls" },
    { "eslint" },
    { "ruff" },
    { "texlab" },
    { "omnisharp" },
    { "bashls" },
}

for _, lsp in pairs(lsps) do
    local name, cfg = lsp[1], lsp[2] or {}
    cfg.capabilities = vim.tbl_deep_extend("force", cfg.capabilities or {}, cmp_caps)
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
end
