-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
      -- Remove trailing whitespace without 'sed'
      -- require("formatter.filetypes.any").substitute_trailing_whitespace,
    }
  }
}

local M = {}

local defaults = require "formatter.defaults"
local util = require "formatter.util"

M.remove_trailing_whitespace = util.withl(defaults.sed, "[ \t]*$")

M.substitute_trailing_whitespace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  vim.cmd [[silent! :keeppatterns %s/[ \t]\+$//ge]]

  -- Restore cursor position without going out of bounds
  local lastline = vim.fn.line "$"
  if line > lastline then
    line = lastline
  end
  vim.api.nvim_win_set_cursor(0, { line, col })
end

return M
