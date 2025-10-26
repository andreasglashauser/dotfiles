local dap = require("dap")

-- 1. Adapter definition (tells nvim-dap how to spawn js-debug-adapter)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- Mason installs the adapter here:
    args = {
      vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

-- 2. One configuration that works for plain Node, TS, React, etc.
local js_configs = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    runtimeExecutable = "node",
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to existing process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
  },
}

-- 3. Register for every JS/TS flavour
for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
  dap.configurations[language] = js_configs
end

