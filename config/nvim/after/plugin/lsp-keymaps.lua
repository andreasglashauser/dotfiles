vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
  callback = function(ev)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    map("n", "K",          vim.lsp.buf.hover,           "Hover docs")
    map("n", "gd",         vim.lsp.buf.definition,      "Goto definition")
    map("n", "gi",         vim.lsp.buf.implementation,  "Goto implementation")
    map("n", "gr",         vim.lsp.buf.references,      "References")
    map("n", "gt",         vim.lsp.buf.type_definition, "Type definition")
    map("n", "<leader>rn", vim.lsp.buf.rename,          "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<C-k>",      vim.lsp.buf.signature_help,  "Signature help")
    map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev,  "Prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next,  "Next diagnostic")
    map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics → loclist")
    map("n", "<leader>f",  function() vim.lsp.buf.format({ async = false }) end, "Format")

    if vim.lsp.inlay_hint then
      map("n", "<leader>th", function()
        local ih = vim.lsp.inlay_hint
        ih.enable(not ih.is_enabled({ buf = ev.buf }), { buf = ev.buf })
      end, "Toggle inlay hints")
    end
  end,
})
