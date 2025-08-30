-- =============================================================================
-- CODE EDITING & REFACTORING
-- =============================================================================
-- Advanced editing features, refactoring, and code manipulation
-- Keybinding prefix: <leader>r for [R]efactor, <leader>c for [C]ode

return {
  -- Mini.move: Move lines and selections
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    opts = {
      mappings = {
        -- Move visual selection in Visual mode with Alt+hjkl
        left = '<A-h>',
        right = '<A-l>',
        down = '<A-j>',
        up = '<A-k>',
        -- Move current line in Normal mode with Alt+jk
        line_left = '',
        line_right = '',
        line_down = '<A-j>',
        line_up = '<A-k>',
      },
    },
  },

  -- Multi-cursor support
  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
    init = function()
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        ['Add Cursor Down'] = '<C-A-j>',
        ['Add Cursor Up'] = '<C-A-k>',
      }
    end,
  },

  -- Refactoring
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {}
      -- Load telescope extension if available
      pcall(function()
        require('telescope').load_extension 'refactoring'
      end)
    end,
    keys = {
      {
        '<leader>rf',
        function()
          require('refactoring').refactor 'Extract Function'
        end,
        desc = '[R]efactor: Extract [F]unction',
        mode = 'x',
      },
      {
        '<leader>rF',
        function()
          require('refactoring').refactor 'Extract Function To File'
        end,
        desc = '[R]efactor: Extract [F]unction to file',
        mode = 'x',
      },
      {
        '<leader>rv',
        function()
          require('refactoring').refactor 'Extract Variable'
        end,
        desc = '[R]efactor: Extract [V]ariable',
        mode = 'x',
      },
      {
        '<leader>ri',
        function()
          require('refactoring').refactor 'Inline Variable'
        end,
        desc = '[R]efactor: [I]nline variable',
        mode = { 'n', 'x' },
      },
      {
        '<leader>rb',
        function()
          require('refactoring').refactor 'Extract Block'
        end,
        desc = '[R]efactor: Extract [B]lock',
        mode = 'n',
      },
      {
        '<leader>rB',
        function()
          require('refactoring').refactor 'Extract Block To File'
        end,
        desc = '[R]efactor: Extract [B]lock to file',
        mode = 'n',
      },
      {
        '<leader>rr',
        function()
          require('telescope').extensions.refactoring.refactors()
        end,
        desc = '[R]efactor: Show [R]efactorings',
        mode = { 'n', 'x' },
      },
    },
  },

  -- Search and replace across project
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').toggle()
        end,
        desc = '[S]earch & [R]eplace (project)',
      },
      {
        '<leader>sR',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        desc = '[S]earch & [R]eplace word',
        mode = 'v',
      },
      {
        '<leader>sp',
        function()
          require('spectre').open_file_search { select_word = true }
        end,
        desc = '[S]earch & replace in file',
      },
    },
  },

  -- Surround operations
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    },
  },

  -- Better text objects
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {
      n_lines = 500,
    },
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
  },

  -- Auto-pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- Integration with cmp
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Todo comments highlighting
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}