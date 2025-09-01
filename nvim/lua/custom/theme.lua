-- =============================================================================
-- UNIFIED THEME SYSTEM
-- =============================================================================
-- Toggle: <leader>xt

local M = {}

local function apply_theme_overrides()
  if vim.o.background == 'light' then
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#f4f4f4', fg = '#2c2c2c' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#f0f0f0', fg = '#2c2c2c' })
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#f0f0f0', fg = '#2c2c2c' })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#e8f2ff', fg = '#2c2c2c', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#e8f2ff' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#f0f0f0' })
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#f0f0f0' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#f4f4f4' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#7a7a7a', bg = '#f4f4f4' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#4d7bd6', bg = '#f0f0f0', bold = true })

    vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#f4f4f4', bg = '#4d7bd6', bold = true })
    vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#f4f4f4', bg = '#52a065' })
    vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#f4f4f4', bg = '#9575cd', bold = true })
    vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#7a7a7a' })

    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#52a065', bg = '#f4f4f4' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#4d7bd6', bg = '#f4f4f4' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#e57373', bg = '#f4f4f4' })

    vim.api.nvim_set_hl(0, 'WhichKey', { fg = '#4d7bd6', bold = true })
    vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = '#9575cd' })
    vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = '#2c2c2c' })
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = '#f0f0f0' })

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#f0f0f0', fg = '#2c2c2c' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#f0f0f0', fg = '#7a7a7a' })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#e8f2ff', fg = '#2c2c2c', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#4d7bd6', bold = true })
  else
    vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#191B20', bg = '#F9E154', bold = true })
    vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#191B20', bg = '#94DD8E' })
    vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#191B20', bg = '#7EB7E6', bold = true })
    vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#515669' })
  end
end

M.toggle_theme = function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
    vim.cmd 'colorscheme oxocarbon'
  else
    vim.o.background = 'dark'
    vim.cmd 'colorscheme minimal'
  end

  apply_theme_overrides()

  local theme_file = os.getenv 'HOME' .. '/.dotfiles_theme'
  local file = io.open(theme_file, 'w')
  if file then
    file:write(vim.o.background .. '\n')
    file:close()
  end
end

local function load_current_theme()
  local theme_file = vim.fn.stdpath 'config' .. '/lua/custom/current-theme.lua'

  if vim.fn.filereadable(theme_file) == 1 then
    dofile(theme_file)
  else
    local global_theme_file = os.getenv 'HOME' .. '/.dotfiles_theme'
    local file = io.open(global_theme_file, 'r')
    if file then
      local theme = file:read '*line'
      file:close()

      if theme == 'light' then
        vim.o.background = 'light'
        vim.cmd 'colorscheme oxocarbon'
      else
        vim.o.background = 'dark'
        vim.cmd 'colorscheme minimal'
      end
    else
      vim.o.background = 'dark'
      vim.cmd 'colorscheme minimal'
    end
  end

  apply_theme_overrides()
end

M.setup = function()
  load_current_theme()
  vim.keymap.set('n', '<leader>xt', M.toggle_theme, { desc = 'Toggle [T]heme' })
end

return M
