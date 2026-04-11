-- =============================================================================
-- UNIFIED THEME SYSTEM (IntelliJ New UI)
-- =============================================================================
-- Toggle: <leader>xt

local M = {}

local function apply_theme_overrides()
  if vim.o.background == 'light' then
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#f7f8fa', fg = '#080808' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#eef0f3', fg = '#080808' })
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#eef0f3', fg = '#080808' })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#d4e2ff', fg = '#080808', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#d4e2ff' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#eef0f3' })
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#eef0f3' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#f7f8fa' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8c8c8c', bg = '#f7f8fa' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#0065cf', bg = '#eef0f3', bold = true })

    vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#f7f8fa', bg = '#0065cf', bold = true })
    vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#f7f8fa', bg = '#067d17' })
    vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#f7f8fa', bg = '#871094', bold = true })
    vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#8c8c8c' })

    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#067d17', bg = '#f7f8fa' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#0065cf', bg = '#f7f8fa' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#cf3737', bg = '#f7f8fa' })

    vim.api.nvim_set_hl(0, 'WhichKey', { fg = '#0065cf', bold = true })
    vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = '#871094' })
    vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = '#080808' })
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = '#eef0f3' })

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#eef0f3', fg = '#080808' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#eef0f3', fg = '#8c8c8c' })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#d4e2ff', fg = '#080808', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#0065cf', bold = true })
  else
    -- IntelliJ New UI Dark overrides
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#1e1f22', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#2b2d30', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#2b2d30', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#214283', fg = '#bcbec4', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#214283' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2d2f34' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#bcbec4', bg = '#2d2f34', bold = true })
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2b2d30' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6f737a', bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#393b40', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#393b40', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#bcbec4', bg = '#2b2d30' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#6f737a', bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'TabLine', { fg = '#6f737a', bg = '#2b2d30' })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'TabLineSel', { fg = '#bcbec4', bg = '#1e1f22', bold = true })

    -- Syntax (IntelliJ New UI Dark - matched to RustRover screenshot)
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#7a7e85', italic = true })
    vim.api.nvim_set_hl(0, 'Keyword', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Conditional', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Repeat', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Statement', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'StorageClass', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'String', { fg = '#6aab73' })
    vim.api.nvim_set_hl(0, 'Character', { fg = '#6aab73' })
    vim.api.nvim_set_hl(0, 'Number', { fg = '#2aacb8' })
    vim.api.nvim_set_hl(0, 'Boolean', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Float', { fg = '#2aacb8' })
    vim.api.nvim_set_hl(0, 'Function', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, 'Identifier', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'Type', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, 'Constant', { fg = '#c77dbb', italic = true })
    vim.api.nvim_set_hl(0, 'Macro', { fg = '#e8bf6a' })
    vim.api.nvim_set_hl(0, 'PreProc', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Include', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Define', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, 'Operator', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'Special', { fg = '#cf8e6d' })
    vim.api.nvim_set_hl(0, 'Tag', { fg = '#e8bf6a' })
    vim.api.nvim_set_hl(0, 'Title', { fg = '#56a8f5', bold = true })
    vim.api.nvim_set_hl(0, 'Todo', { fg = '#f2c55c', bold = true })
    vim.api.nvim_set_hl(0, 'Error', { fg = '#f75464' })
    vim.api.nvim_set_hl(0, 'WarningMsg', { fg = '#f2c55c' })

    -- Inlay hints (subtle muted style like IntelliJ type hints)
    vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#6f737a', bg = '#2d2f34', italic = true })

    -- LSP reference highlighting (underline like IntelliJ)
    vim.api.nvim_set_hl(0, 'LspReferenceText', { underline = true })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { underline = true })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { underline = true, bold = true })

    -- Treesitter overrides for precise IntelliJ mapping
    vim.api.nvim_set_hl(0, '@keyword', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.return', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.operator', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.import', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@conditional', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@repeat', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@exception', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@string', { fg = '#6aab73' })
    vim.api.nvim_set_hl(0, '@string.escape', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@string.regex', { fg = '#cf8e6d' })
    vim.api.nvim_set_hl(0, '@string.special', { fg = '#cf8e6d' })
    vim.api.nvim_set_hl(0, '@number', { fg = '#2aacb8' })
    vim.api.nvim_set_hl(0, '@boolean', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@float', { fg = '#2aacb8' })
    vim.api.nvim_set_hl(0, '@function', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, '@function.call', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, '@function.macro', { fg = '#e8bf6a' })
    vim.api.nvim_set_hl(0, '@method', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, '@method.call', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, '@constructor', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@type', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@type.qualifier', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@variable', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@variable.builtin', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@variable.parameter', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@variable.member', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@property', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@field', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@parameter', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@constant', { fg = '#c77dbb', italic = true })
    vim.api.nvim_set_hl(0, '@constant.builtin', { fg = '#cf8e6d', bold = true })
    vim.api.nvim_set_hl(0, '@constant.macro', { fg = '#e8bf6a' })
    vim.api.nvim_set_hl(0, '@comment', { fg = '#7a7e85', italic = true })
    vim.api.nvim_set_hl(0, '@operator', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@punctuation', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@punctuation.special', { fg = '#cf8e6d' })
    vim.api.nvim_set_hl(0, '@tag', { fg = '#e8bf6a' })
    vim.api.nvim_set_hl(0, '@tag.attribute', { fg = '#bababa' })
    vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@attribute', { fg = '#bbb529' })
    vim.api.nvim_set_hl(0, '@annotation', { fg = '#bbb529' })
    vim.api.nvim_set_hl(0, '@namespace', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@module', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, '@label', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, '@markup.heading', { fg = '#56a8f5', bold = true })
    vim.api.nvim_set_hl(0, '@markup.link', { fg = '#56a8f5', underline = true })
    vim.api.nvim_set_hl(0, '@markup.strong', { bold = true })
    vim.api.nvim_set_hl(0, '@markup.italic', { italic = true })
    vim.api.nvim_set_hl(0, '@markup.raw', { fg = '#6aab73' })

    -- Diagnostics
    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#f75464' })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#f2c55c' })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#56a8f5' })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#6aab73' })

    -- DAP debugger highlights
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#3a3529' })
    vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#f2c55c', bg = '#3a3529' })
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#f75464' })
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#f2c55c' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#56a8f5' })

    -- Flash (search/jump)
    vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#1e1f22', bg = '#f2c55c', bold = true })
    vim.api.nvim_set_hl(0, 'FlashMatch', { fg = '#1e1f22', bg = '#6aab73' })
    vim.api.nvim_set_hl(0, 'FlashCurrent', { fg = '#1e1f22', bg = '#56a8f5', bold = true })
    vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#6f737a' })

    -- Git signs
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#6aab73', bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#56a8f5', bg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#f75464', bg = '#1e1f22' })

    -- Which-key
    vim.api.nvim_set_hl(0, 'WhichKey', { fg = '#56a8f5', bold = true })
    vim.api.nvim_set_hl(0, 'WhichKeyGroup', { fg = '#c77dbb' })
    vim.api.nvim_set_hl(0, 'WhichKeyDesc', { fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = '#2b2d30' })

    -- Telescope
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#2b2d30', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#2b2d30', fg = '#393b40' })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#214283', fg = '#bcbec4', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#56a8f5', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#2b2d30', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#2b2d30', fg = '#393b40' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = '#1e1f22', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#1e1f22', fg = '#393b40' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = '#1e1f22', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#1e1f22', fg = '#393b40' })

    -- Treesitter context
    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#2b2d30' })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { fg = '#6f737a', bg = '#2b2d30' })

    -- Search
    vim.api.nvim_set_hl(0, 'Search', { bg = '#214283', fg = '#bcbec4' })
    vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#f2c55c', fg = '#1e1f22' })
    vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#f2c55c', fg = '#1e1f22' })

    -- Diff
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#2a3b2d' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#2a3045' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#3b2a2d' })
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#3a4560' })

    -- Folding
    vim.api.nvim_set_hl(0, 'Folded', { fg = '#6f737a', bg = '#2b2d30' })
    vim.api.nvim_set_hl(0, 'FoldColumn', { fg = '#6f737a', bg = '#1e1f22' })

    -- Misc UI
    vim.api.nvim_set_hl(0, 'NonText', { fg = '#393b40' })
    vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#393b40' })
    vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#393b40', bold = true })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#393b40', bg = '#2b2d30' })
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
