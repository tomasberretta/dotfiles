-- =============================================================================
-- WRITING & MARKDOWN SUPPORT
-- =============================================================================
-- Markdown, Obsidian, and focus mode for writing
-- Keybinding prefix: <leader>z for [Z]en/writing modes

return {
  -- Zen Mode for focused writing
  {
    'folke/zen-mode.nvim',
    dependencies = {
      'folke/twilight.nvim',
    },
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
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
    keys = {
      { '<leader>zz', '<cmd>ZenMode<cr>', desc = 'Toggle [Z]en mode' },
    },
  },

  -- Twilight: Dim inactive code blocks
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
      expand = {
        'function',
        'method',
        'table',
        'if_statement',
      },
    },
    keys = {
      { '<leader>zt', '<cmd>Twilight<cr>', desc = 'Toggle [T]wilight dimming' },
    },
  },

  -- Pencil for better word wrapping
  {
    'preservim/vim-pencil',
    cmd = { 'Pencil', 'PencilOff', 'PencilToggle' },
    keys = {
      { '<leader>zp', '<cmd>PencilToggle<cr>', desc = 'Toggle [P]encil mode' },
    },
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    keys = {
      { '<leader>zm', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle [M]arkdown preview' },
    },
  },

  -- Obsidian integration (optional, uncomment if using Obsidian)
  -- {
  --   'epwalsh/obsidian.nvim',
  --   version = '*',
  --   lazy = true,
  --   ft = 'markdown',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = 'personal',
  --         path = '~/vaults/personal',
  --       },
  --     },
  --   },
  --   keys = {
  --     { 'gf', function() return require('obsidian').util.gf_passthrough() end, desc = 'Go to file under cursor' },
  --     { '<leader>zo', '<cmd>ObsidianOpen<cr>', desc = '[O]pen in Obsidian' },
  --     { '<leader>zn', '<cmd>ObsidianNew<cr>', desc = '[N]ew Obsidian note' },
  --     { '<leader>zs', '<cmd>ObsidianSearch<cr>', desc = '[S]earch Obsidian' },
  --     { '<leader>zq', '<cmd>ObsidianQuickSwitch<cr>', desc = '[Q]uick switch note' },
  --   },
  -- },

  -- Additional writing helpers
  vim.keymap.set('n', '<leader>zs', function()
    vim.opt.spell = not vim.opt.spell:get()
    if vim.opt.spell:get() then
      vim.notify('Spell check enabled', vim.log.levels.INFO)
    else
      vim.notify('Spell check disabled', vim.log.levels.INFO)
    end
  end, { desc = 'Toggle [S]pell check' }),
}