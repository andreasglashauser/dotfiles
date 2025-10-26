local ok_dap, dap = pcall(require, "dap")
if not ok_dap then return end
local ok_ui, dapui = pcall(require, "dapui")
if ok_ui then
  dapui.setup()
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

local map = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = "DAP: " .. desc }) end
map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional breakpoint")
map("<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Log point")

map("<leader>dc", dap.continue, "Continue")
map("<leader>dn", dap.step_over, "Step over")
map("<leader>di", dap.step_into, "Step into")
map("<leader>do", dap.step_out, "Step out")
map("<leader>dr", dap.restart, "Restart")
map("<leader>dR", dap.repl.toggle, "REPL")
if ok_ui then map("<leader>du", dapui.toggle, "Toggle UI") end
