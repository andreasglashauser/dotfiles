vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup({
  view = {
    side = "left",
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  git = {
    enable = true,
  },
  update_focused_file = {
      enable = true,
      update_root = false,
  },
})

local function in_git_repo()
  local bufdir = vim.fn.expand("%:p:h")
  if bufdir == "" then
    bufdir = vim.fn.getcwd()
  end

  local git_dir = vim.fn.finddir(".git", bufdir .. ";")
  return git_dir ~= ""
end

local function open_tree_if_git()
  if vim.bo.filetype == "NvimTree" then
    return
  end

  if not in_git_repo() then
    return
  end

  if vim.g._nvim_tree_auto_opened then
    return
  end
  vim.g._nvim_tree_auto_opened = true

  require("nvim-tree.api").tree.open()
  vim.cmd("wincmd p")
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = open_tree_if_git,
})
