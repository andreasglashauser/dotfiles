local ok, dap_python = pcall(require, "dap-python")
if not ok then
  return
end

local uv = vim.uv or vim.loop

local mason_venv = vim.fs.joinpath(
  vim.fn.stdpath("data"),
  "mason",
  "packages",
  "debugpy",
  "venv"
)

local debugpy_python
if vim.fn.has("win32") == 1 then
  debugpy_python = vim.fs.joinpath(mason_venv, "Scripts", "python.exe")
else
  debugpy_python = vim.fs.joinpath(mason_venv, "bin", "python")
end

if not uv.fs_stat(debugpy_python) then
  vim.notify(
    ("dap-python: debugpy python not found at:\n%s\nInstall it with :MasonInstall debugpy"):format(debugpy_python),
    vim.log.levels.WARN
  )
  return
end

dap_python.setup(debugpy_python)
