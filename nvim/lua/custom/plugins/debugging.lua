-- =============================================================================
-- DEBUGGING (DAP) - Under <leader>r (Run)
-- =============================================================================
-- Debug keymaps merged with Run/Test for unified execution workflow

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = { 'python', 'js' },
        handlers = {},
      }

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        expand_lines = false,
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = { 'repl', 'console' },
            size = 0.25,
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = 'single',
          mappings = { close = { 'q', '<Esc>' } },
        },
        windows = { indent = 1 },
        render = { max_type_length = nil, max_value_lines = 100 },
      }

      require('nvim-dap-virtual-text').setup {
        commented = true,
        display_callback = function(variable, _, _, _)
          return ' ' .. variable.name .. ' = ' .. variable.value
        end,
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Debug keymaps under <leader>r (Run)
      vim.keymap.set('n', '<leader>rb', dap.toggle_breakpoint, { desc = '[R]un: [B]reakpoint toggle' })
      vim.keymap.set('n', '<leader>rB', function()
        dap.set_breakpoint(vim.fn.input 'Condition: ')
      end, { desc = '[R]un: [B]reakpoint conditional' })
      vim.keymap.set('n', '<leader>rL', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log: ')
      end, { desc = '[R]un: [L]og point' })

      vim.keymap.set('n', '<leader>rc', dap.continue, { desc = '[R]un: [C]ontinue debug' })
      vim.keymap.set('n', '<leader>rx', dap.terminate, { desc = '[R]un: e[X]it debug' })
      vim.keymap.set('n', '<leader>rR', dap.restart, { desc = '[R]un: [R]estart debug' })
      vim.keymap.set('n', '<leader>rl', dap.run_last, { desc = '[R]un: [L]ast debug' })
      vim.keymap.set('n', '<leader>rC', dap.run_to_cursor, { desc = '[R]un: to [C]ursor' })

      vim.keymap.set('n', '<leader>ri', dap.step_into, { desc = '[R]un: step [I]nto' })
      vim.keymap.set('n', '<leader>ro', dap.step_over, { desc = '[R]un: step [O]ver' })
      vim.keymap.set('n', '<leader>rO', dap.step_out, { desc = '[R]un: step [O]ut' })

      vim.keymap.set('n', '<leader>ru', dapui.toggle, { desc = '[R]un: debug [U]I' })
      vim.keymap.set('n', '<leader>re', dapui.eval, { desc = '[R]un: [E]valuate' })
      vim.keymap.set('v', '<leader>re', dapui.eval, { desc = '[R]un: [E]valuate selection' })
      vim.keymap.set('n', '<leader>rp', dap.repl.toggle, { desc = '[R]un: RE[P]L' })

      -- F-keys for fast stepping
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    end,
  },
}
