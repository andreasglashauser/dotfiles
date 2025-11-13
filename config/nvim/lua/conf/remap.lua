vim.g.mapleader = " "

-- In Visual mode, map J and K to move the selected block down or up one line, reselect it, and re‑indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<Space>h', ':noh<CR>')

