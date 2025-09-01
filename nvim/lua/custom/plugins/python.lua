-- =============================================================================
-- PYTHON DEVELOPMENT - Under <leader>r (Run)
-- =============================================================================
-- Python venv, debugging, and testing integrated into Run workflow

return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
    ft = 'python',
    opts = {
      name = { '.venv', 'venv', 'env' },
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      parents = 2,
      poetry_path = vim.fn.expand '~/.cache/pypoetry/virtualenvs',
      pipenv_path = vim.fn.expand '~/.local/share/virtualenvs',
      anaconda_base_path = vim.fn.expand '~/anaconda3',
      anaconda_envs_path = vim.fn.expand '~/anaconda3/envs',
      pyenv_path = vim.fn.expand '~/.pyenv/versions',
      notify_user_on_activate = true,
    },
    keys = {
      { '<leader>rv', '<cmd>VenvSelect<cr>', desc = '[R]un: [V]env select' },
      { '<leader>rV', '<cmd>VenvSelectCached<cr>', desc = '[R]un: [V]env cached' },
    },
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
      require('dap-python').test_runner = 'pytest'
    end,
    keys = {
      {
        '<leader>rm',
        function()
          require('dap-python').test_method()
        end,
        desc = '[R]un: test [M]ethod (Python)',
      },
      {
        '<leader>rk',
        function()
          require('dap-python').test_class()
        end,
        desc = '[R]un: test [K]lass (Python)',
      },
      {
        '<leader>rs',
        function()
          require('dap-python').debug_selection()
        end,
        desc = '[R]un: debug [S]election',
        mode = 'v',
      },
    },
  },

  {
    'nvim-neotest/neotest',
    ft = 'python',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
            python = '.venv/bin/python',
          },
        },
        icons = {
          expanded = '',
          child_prefix = '',
          child_indent = '',
          final_child_prefix = '',
          non_collapsible = '',
          collapsed = '',
          passed = '',
          running = '',
          failed = '',
          unknown = '',
        },
      }
    end,
    keys = {
      {
        '<leader>rr',
        function()
          require('neotest').run.run()
        end,
        desc = '[R]un: [R]un test nearest',
      },
      {
        '<leader>rf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[R]un: [F]ile tests',
      },
      {
        '<leader>rd',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = '[R]un: [D]ebug test',
      },
      {
        '<leader>rS',
        function()
          require('neotest').run.stop()
        end,
        desc = '[R]un: [S]top test',
      },
      {
        '<leader>ra',
        function()
          require('neotest').run.attach()
        end,
        desc = '[R]un: [A]ttach test',
      },
      {
        '<leader>rw',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = '[R]un: output [W]indow',
      },
      {
        '<leader>rW',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = '[R]un: output [W]indow panel',
      },
      {
        '<leader>rt',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[R]un: [T]est summary',
      },
    },
  },
}
