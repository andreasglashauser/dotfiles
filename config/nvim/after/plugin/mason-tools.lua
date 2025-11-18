local ok, registry = pcall(require, "mason-registry")
if not ok then return end

local tools = {
  "prettierd",
  "csharpier",
  "ruff",
  "debugpy",
  "js-debug-adapter",
  "netcoredbg",
  "uv",
  "sonarlint-language-server",
  "bash-language-server",
  "shellcheck",
  "shfmt",
  "glow",
  "typstyle",
}

local function ensure_installed()
  for _, name in ipairs(tools) do
    local ok_pkg, pkg = pcall(registry.get_package, name)
    if ok_pkg then
      if not pkg:is_installed() then
        pkg:install()
        vim.notify("Mason: installing " .. name .. "…")
      end
    else
      vim.notify("Mason: package not found: " .. name, vim.log.levels.WARN)
    end
  end
end

if registry.refresh then
  registry.refresh(ensure_installed)
else
  ensure_installed()
end

