vim.keymap.set("n", "<leader>mp", function()
  vim.cmd("rightbelow vsplit | terminal glow --tui %")
end, { desc = "Markdown preview (glow) on the right" })
