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

-- Custom theme matching tmux style
vim.api.nvim_set_hl(0, "Normal", { bg = "#1c1c1c", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1c1c1c", fg = "#d0d0d0" })

-- Line numbers with tmux-like colors
vim.api.nvim_set_hl(0, "LineNr", { fg = "#585858", bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00d7ff", bg = "#1c1c1c", bold = true })

-- Color column
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#262626" })

-- Visual selection
vim.api.nvim_set_hl(0, "Visual", { bg = "#444444" })

-- Search highlighting
vim.api.nvim_set_hl(0, "Search", { bg = "#5f8700", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#d75f00", fg = "#ffffff" })

-- Comments
vim.api.nvim_set_hl(0, "Comment", { fg = "#808080", italic = true })

-- Global statusline (one bar for all windows)
vim.o.laststatus = 3
vim.o.showmode = false

-- Statusline colors matching tmux
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#262626", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1c1c1c", fg = "#808080" })

vim.o.statusline = table.concat({
    "%#StatusLine#",
    " %f",                -- filename
    " %m%r%h%w",          -- flags
    "%=",                 -- right align
    "%#Search#",          -- highlight mode
    " %{toupper(mode())} ", -- current mode (uppercase)
    "%#StatusLine#",      -- back to normal
    " %y",                -- filetype
    " %l:%c ",            -- line:col
    " %p%% ",             -- percent through file
})

-- Disable matchparen plugin (was causing cursor to jump between brackets in HTML files
-- after recent config updates - normally this plugin only highlights matching brackets)
vim.g.loaded_matchparen = 1


vim.diagnostic.config({
    virtual_text = { severity = { min = vim.diagnostic.severity.HINT } },
    signs         = { severity = { min = vim.diagnostic.severity.HINT } },
    underline     = { severity = { min = vim.diagnostic.severity.HINT } },
    severity_sort = true, -- sort diagnostic by severity
    update_in_insert = false, -- dont update diagnostics while typing
    --virtual_lines = true,
})
