-- This will automatically configure dap for python.
-- It will try to find the python interpreter in your virtual environment.
require('dap-python').setup()

-- Setup dap-ui
local dapui = require("dapui")
dapui.setup()

-- Auto-open/close dap-ui when debugging starts/ends
local dap = require('dap')
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Keymaps for debugging
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = "DAP: Continue" })
vim.keymap.set('n', '<leader>dso', require('dap').step_over, { desc = "DAP: Step Over" })
vim.keymap.set('n', '<leader>dsi', require('dap').step_into, { desc = "DAP: Step Into" })
vim.keymap.set('n', '<leader>dsu', require('dap').step_out, { desc = "DAP: Step Out" })
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = "DAP UI: Toggle" })

-- Variable inspection
local dap = require('dap')
local widgets = require('dap.ui.widgets')

-- 1) Keybinding: show value under cursor
vim.keymap.set({'n','v'}, '<leader>dv', function()
  if dap.session() then
    widgets.hover()
  end
end, { desc = "Show value (DAP if debugging)", silent = true })

