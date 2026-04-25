-- =============================================================================
-- WRITING & MARKDOWN - Toggles under <leader>x
-- =============================================================================
-- Zen mode and dimming live in plugins/snacks.lua (Snacks.zen, Snacks.dim)

return {
  {
    'preservim/vim-pencil',
    cmd = { 'Pencil', 'PencilOff', 'PencilToggle' },
    keys = {
      { '<leader>xp', '<cmd>PencilToggle<cr>', desc = 'Toggle [P]encil mode' },
    },
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    keys = {
      { '<leader>xm', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle [M]arkdown preview' },
    },
  },
}
