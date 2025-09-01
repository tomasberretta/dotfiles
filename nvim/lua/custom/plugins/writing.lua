-- =============================================================================
-- WRITING & MARKDOWN - Toggles under <leader>x
-- =============================================================================

return {
  {
    'folke/zen-mode.nvim',
    dependencies = { 'folke/twilight.nvim' },
    cmd = { 'ZenMode' },
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        options = { enabled = true, ruler = false, showcmd = false },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
    keys = {
      { '<leader>xz', '<cmd>ZenMode<cr>', desc = 'Toggle [Z]en mode' },
    },
  },

  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    opts = {
      dimming = {
        alpha = 0.25,
        color = { 'Normal', '#ffffff' },
        term_bg = '#000000',
        inactive = false,
      },
      context = 10,
      treesitter = true,
      expand = { 'function', 'method', 'table', 'if_statement' },
    },
    keys = {
      { '<leader>xd', '<cmd>Twilight<cr>', desc = 'Toggle [D]im (twilight)' },
    },
  },

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
