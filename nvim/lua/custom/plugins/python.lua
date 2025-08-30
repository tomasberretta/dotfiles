-- =============================================================================
-- PYTHON DEVELOPMENT
-- =============================================================================
-- Virtual environments, debugging, and testing for Python
-- Keybinding prefix: <leader>v for [V]env, <leader>d for [D]ebug

return {
  -- Virtual environment selector
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
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = '[V]env [S]elect' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = '[V]env [C]ached' },
    },
  },

  -- Debug Adapter Protocol for Python
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
      
      -- Python-specific debug configurations
      require('dap-python').test_runner = 'pytest'
    end,
    keys = {
      { '<leader>dpm', function() require('dap-python').test_method() end, desc = '[D]ebug [P]ython [M]ethod' },
      { '<leader>dpc', function() require('dap-python').test_class() end, desc = '[D]ebug [P]ython [C]lass' },
      { '<leader>dps', function() require('dap-python').debug_selection() end, desc = '[D]ebug [P]ython [S]election', mode = 'v' },
    },
  },

  -- Neotest for Python
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
      { '<leader>tr', function() require('neotest').run.run() end, desc = '[T]est [R]un nearest' },
      { '<leader>tR', function() require('neotest').run.run(vim.fn.expand '%') end, desc = '[T]est [R]un file' },
      { '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end, desc = '[T]est [D]ebug nearest' },
      { '<leader>ts', function() require('neotest').run.stop() end, desc = '[T]est [S]top' },
      { '<leader>ta', function() require('neotest').run.attach() end, desc = '[T]est [A]ttach' },
      { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = '[T]est [O]utput' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = '[T]est [O]utput panel' },
      { '<leader>tS', function() require('neotest').summary.toggle() end, desc = '[T]est [S]ummary' },
    },
  },

  -- Python-specific formatting and linting (handled by LSP config)
  -- Ensure these are installed via Mason:
  -- - pyright or pylsp (LSP)
  -- - black (formatter)
  -- - isort (import sorter)
  -- - ruff (linter)
}