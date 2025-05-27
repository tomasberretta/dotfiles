-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Toggle for trimming whitespace on save
vim.g.auto_trim_whitespace_on_save = true

local function trim_whitespace()
  if not vim.g.auto_trim_whitespace_on_save then
    return
  end

  local current_view = vim.fn.winsaveview()
  -- Preserve cursor position and window view
  -- Remove trailing whitespace from all lines
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(current_view)
end

-- Autocommand group for formatting on save
local format_on_save_group = vim.api.nvim_create_augroup("UserFormatOnSave", { clear = true })

-- Autocommand to trim whitespace before writing the buffer
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save_group,
  pattern = "*", -- Apply to all file types
  callback = trim_whitespace,
  desc = "Trim trailing whitespace before saving",
})

-- User command to toggle the whitespace trimming
vim.api.nvim_create_user_command("ToggleTrimWhitespaceOnSave", function()
  vim.g.auto_trim_whitespace_on_save = not vim.g.auto_trim_whitespace_on_save
  if vim.g.auto_trim_whitespace_on_save then
    vim.notify("Auto trim whitespace on save: ENABLED", vim.log.levels.INFO)
  else
    vim.notify("Auto trim whitespace on save: DISABLED", vim.log.levels.INFO)
  end
end, {
  desc = "Toggle automatic trimming of trailing whitespace on save",
})
