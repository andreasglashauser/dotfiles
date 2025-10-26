local mason = vim.fn.stdpath("data") .. "/mason"
local analyzer_dir = mason .. "/share/sonarlint-analyzers"

local ft = { "python", "javascript", "typescript", "c", "cpp", "cs", "html", "xml", "javascriptreact", "typescriptreact" }

local only_relevant = true

local ft_to_analyzer = {
  python = "sonarpython",
  javascript = "sonarjs",
  javascriptreact = "sonarjs",
  typescript = "sonarjs",
  typescriptreact = "sonarjs",
  c = "sonarcfamily",
  cpp = "sonarcfamily",
  cs = "sonarlintomnisharp",
  java = "sonarjava",
  go = "sonargo",
  php = "sonarphp",
  ruby = "sonarruby",
  kotlin = "sonarkotlin",
  html = "sonarhtml",
  xml = "sonarxml",
}

local all_jars = vim.fn.globpath(analyzer_dir, "*.jar", true, true) or {}
table.sort(all_jars)

local jars
if only_relevant then
  local want = {}
  for _, f in ipairs(ft) do
    local key = ft_to_analyzer[f]
    if key then want[key] = true end
  end
  jars = {}
  for _, p in ipairs(all_jars) do
    for key in pairs(want) do
      if string.find(p, key, 1, true) then
        table.insert(jars, p)
        break
      end
    end
  end
else
  jars = all_jars
end

local exe = vim.fn.exepath("sonarlint-language-server")
if exe == "" then
  exe = mason .. "/bin/sonarlint-language-server"
end

local cmd = { exe, "-stdio" }
if #jars > 0 then
  table.insert(cmd, "-analyzers")
  vim.list_extend(cmd, jars)
else
  vim.notify("SonarLint: no analyzers found in " .. analyzer_dir, vim.log.levels.WARN)
end

require("sonarlint").setup({
  server = {
    cmd = cmd,
    settings = {
      sonarlint = {
        disableTelemetry = true,
      },
    },
  },
  filetypes = ft,
})

