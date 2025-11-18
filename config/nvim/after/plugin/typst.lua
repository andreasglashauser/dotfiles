-- typst.lua

-- super simple "open this file with the default viewer" helper
local function open_pdf(path)
  vim.ui.open(vim.fs.normalize(path))
end

local function export_and_open_pdf()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd.write() -- save current buffer

  local entry = vim.api.nvim_buf_get_name(bufnr)

  -- find tinymist attached to this buffer
  local clients = vim.lsp.get_clients({ name = "tinymist", bufnr = bufnr })
  if #clients == 0 then
    -- minimal fallback: one-off CLI compile, then open
    local pdf = entry:gsub("%.typ$", "") .. ".pdf"
    vim.system({ "typst", "c", entry, pdf }, {}, function(obj)
      if obj.code == 0 then
        open_pdf(pdf)
      else
        vim.notify("typst compile failed", vim.log.levels.ERROR)
      end
    end)
    return
  end

  local client = clients[1]

  -- tinymist Neovim export command:
  -- 1st arg: path (string)
  -- 2nd arg: options table
  client:request(
    "workspace/executeCommand",
    {
      command = "tinymist.exportPdf",
      arguments = { entry, { open = false, write = true } },
    },
    function(err, result)
      if err then
        vim.notify("tinymist export failed: " .. (err.message or ""), vim.log.levels.ERROR)
        return
      end

      local pdf
      if type(result) == "table" then
        -- result is either { path = "..." } or { items = { { path = "..." }, ... } }
        pdf = result.path
          or (result.items and result.items[1] and result.items[1].path)
      end

      if pdf and pdf ~= "" then
        open_pdf(pdf)
      else
        -- last-resort guess: same basename, .pdf
        open_pdf(entry:gsub("%.typ$", "") .. ".pdf")
      end
    end,
    bufnr
  )
end

-- keymap: Typst export & open PDF
vim.keymap.set("n", "<leader>tp", export_and_open_pdf, {
  desc = "Typst: export & open PDF",
})

return {}

