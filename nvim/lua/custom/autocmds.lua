-- =============================================================================
-- AUTOCOMMANDS
-- =============================================================================

-- Highlight when yanking (copying) text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace and collapse multiple blank lines on save
local whitespace_group = vim.api.nvim_create_augroup('TrimWhitespace', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace and collapse blank lines',
  group = whitespace_group,
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\n\{3,}/\r\r/e]])
    vim.fn.setpos('.', save_cursor)
  end,
})
