local function open_glow()
  local file = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  vim.cmd("rightbelow vsplit | terminal glow --tui " .. file)
end

vim.keymap.set("n", "<leader>mp", open_glow, { desc = "Markdown preview (glow) on the right" })

local glow_group = vim.api.nvim_create_augroup("GlowMarkdownPreview", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = glow_group,
  pattern = "*.md",
  callback = open_glow,
})
