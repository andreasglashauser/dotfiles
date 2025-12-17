local function open_glow()
  local file = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  vim.cmd("rightbelow vsplit | terminal glow --tui " .. file)
end

vim.keymap.set("n", "<leader>mp", open_glow, { desc = "Markdown preview (glow) on the right" })
