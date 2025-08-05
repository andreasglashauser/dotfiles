-- show absolute line numbers
vim.opt.number = true
-- also show relative line numbers to the cursor
vim.opt.relativenumber = true

-- display a tab as 4 spaces wide
vim.opt.tabstop = 4
-- treat typed tabs as 4 spaces (while editing)
vim.opt.softtabstop = 4
-- use 4 spaces when auto-indenting
vim.opt.shiftwidth = 4
-- convert typed tabs into spaces
vim.opt.expandtab = true

-- uses smart auto indentation based on syntax context
vim.opt.smartindent = true

-- dont wrap long lines, scroll horizontally instead
vim.opt.wrap = false

-- directory for storing persistent undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- enable persistent undo so you can undo accross sessions
vim.opt.undofile = true

-- ignore case in search patterns ...
vim.opt.ignorecase = true
-- ..but override ignorecase if typing any uppercase letter
vim.opt.smartcase = true
-- show matches as you type instead of waiting for <Enter>
vim.opt.incsearch = true

-- keeps cursor centered by effectively disabling vertical scrolling
vim.opt.scrolloff = 100000

-- always keeps a dedicated gutter on the left for "signs" (eg git changes, breakpoints, lint errors)
vim.opt.signcolumn = "yes"

-- decreases update time for CursorHold (improves responsiveness)
-- lower value makes things like diagnostic pop-ups and other
-- plugins feel more reponsive
vim.opt.updatetime = 50

-- higlights column 70 as a visual guide for line length
vim.opt.colorcolumn = "100"

-- set colorscheme
vim.cmd.colorscheme("slate")

-- make background darker like habamax
vim.api.nvim_set_hl(0, "Normal", { bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1c1c1c" })

-- make colorcolumn grey like habamax
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3a3a3a" })

-- Global statusline (one bar for all windows)
vim.o.laststatus = 3
-- Don’t show duplicate “-- INSERT --” since the statusline will show mode
vim.o.showmode = false

vim.o.statusline = table.concat({
  " %f",          -- filename
  " %m%r%h%w",    -- flags: [+] modified, RO, help, preview
  " %=",          -- right align the rest
  " %{mode()}",   -- current mode
  " %y",          -- filetype
  " %l:%c",       -- line:col
  " %p%%",        -- percent through file
})

