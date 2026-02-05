local M = {}

vim.g.latex_autosave = 1
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_automatic = 0 -- so that the pdf viewer doesnt open twice

vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
  out_dir = "build",
  continuous = 1,
  callback = 1,
  executable = "latexmk",
  options = {
    "-pdf",
    "-file-line-error",
    "-interaction=nonstopmode",
    "-synctex=1",
  },
}

vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_quickfix_open_on_warning = 1
vim.g.vimtex_quickfix_autojump = 0
vim.g.vimtex_matchparen_enabled = 0

local function vimtex_cmd_exists(name)
  return vim.fn.exists(":" .. name) == 2
end

local function compiler_running()
  if vim.fn.exists("*vimtex#compiler#is_running") == 1 then
    local ok, res = pcall(vim.fn["vimtex#compiler#is_running"])
    return ok and res == 1
  end
  return false
end

function M.preview()
  if vim.bo.filetype ~= "tex" then
    vim.notify("VimTeX preview: not a TeX buffer", vim.log.levels.WARN)
    return
  end
  if not vimtex_cmd_exists("VimtexCompile") then
    vim.notify("VimTeX commands not available (is lervag/vimtex installed/loaded?)", vim.log.levels.ERROR)
    return
  end

  if not compiler_running() then
    vim.cmd("silent VimtexCompile!")
  end
  vim.cmd("silent VimtexView")
end

function M.stop()
  if vimtex_cmd_exists("VimtexStop") then
    vim.cmd("silent VimtexStop")
  end
end

local aug = vim.api.nvim_create_augroup("latex_vimtex", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = "tex",
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "<leader>lp", M.preview, vim.tbl_extend("force", opts, {
      desc = "VimTeX: compile (continuous) + view",
    }))

    vim.keymap.set("n", "<leader>ls", M.stop, vim.tbl_extend("force", opts, {
      desc = "VimTeX: stop compiler",
    }))

    vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<cr>", vim.tbl_extend("force", opts, {
      desc = "VimTeX: errors/warnings (quickfix)",
    }))
    vim.keymap.set("n", "<leader>lo", "<cmd>VimtexCompileOutput<cr>", vim.tbl_extend("force", opts, {
      desc = "VimTeX: compiler output (full log)",
    }))

  end,
})

return M
