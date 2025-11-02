vim.g.mapleader = " "

-- In Normal mode, map <leader>ex (Space → e → x) to open the built‑in file explorer (:Ex)
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- In Visual mode, map J and K to move the selected block down or up one line, reselect it, and re‑indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<Space>h', ':noh<CR>')

