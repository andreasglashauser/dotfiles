vim.keymap.set("n", "<leader>lp", function()
  vim.cmd.write()
  local tex = vim.api.nvim_buf_get_name(0)
  -- compile with latexmk and watch for changes
  vim.fn.jobstart({ "latexmk", "-pdf", "-pvc", "-interaction=nonstopmode", tex }, { detach = true })

  local pdf = vim.fn.fnamemodify(tex, ":r") .. ".pdf"

  local open_cmd
  if vim.fn.has("win32") == 1 then
    open_cmd = { "cmd.exe", "/C", "start", "", pdf }
  elseif vim.fn.executable("wslview") == 1 then
    open_cmd = { "wslview", pdf }
  else
    open_cmd = { "xdg-open", pdf }
  end
  vim.fn.jobstart(open_cmd, { detach = true })
end, { desc = "LaTeX: build & open PDF (default viewer)" })
