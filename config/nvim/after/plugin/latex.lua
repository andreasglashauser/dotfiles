vim.keymap.set("n", "<leader>lp", function()
  vim.cmd.write()

  local tex_path = vim.api.nvim_buf_get_name(0)
  if tex_path == "" then return end

  local dir  = vim.fs.dirname(tex_path)
  local file = vim.fs.basename(tex_path)
  local stem = file:gsub("%.tex$", "")
  local outdir = dir .. "/target"

  vim.fn.mkdir(outdir, "p")

  vim.fn.jobstart({
    "latexmk",
    "-pdf",
    "-pvc",
    "-interaction=nonstopmode",
    "-outdir=target",
    file,
  }, {
    cwd = dir,
    detach = true,
  })

  local pdf = outdir .. "/" .. stem .. ".pdf"
  vim.ui.open(pdf)
end, { desc = "LaTeX: build & open PDF (target/)" })

