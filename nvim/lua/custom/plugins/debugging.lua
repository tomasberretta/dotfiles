-- =============================================================================
-- DEBUGGING (DAP)
-- =============================================================================
-- Debug Adapter Protocol for multiple languages
-- Keybinding prefix: <leader>d for [D]ebug

return {
  -- Core DAP
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- UI for DAP
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      
      -- Virtual text for debugging
      'theHamsta/nvim-dap-virtual-text',
      
      -- Mason integration for DAP
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Mason DAP setup
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {
          'python',
          'js',
        },
        handlers = {},
      }

      -- DAP UI setup
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
            elements = {
              'repl',
              'console',
            },
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
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      }

      -- Virtual text setup
      require('nvim-dap-virtual-text').setup {
        commented = true,
        display_callback = function(variable, _buf, _stackframe, _node)
          return ' ' .. variable.name .. ' = ' .. variable.value
        end,
      }

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- DAP keymaps
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug [B]reakpoint toggle' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = '[D]ebug [B]reakpoint conditional' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[D]ebug step [O]ut' })
      vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = '[D]ebug [R]EPL' })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[D]ebug run [L]ast' })
      vim.keymap.set('n', '<leader>dh', function()
        require('dap.ui.widgets').hover()
      end, { desc = '[D]ebug [H]over' })
      vim.keymap.set('n', '<leader>dp', function()
        require('dap.ui.widgets').preview()
      end, { desc = '[D]ebug [P]review' })
      vim.keymap.set('n', '<leader>df', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end, { desc = '[D]ebug [F]rames' })
      vim.keymap.set('n', '<leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes)
      end, { desc = '[D]ebug [S]copes' })
      vim.keymap.set('n', '<leader>dk', dap.terminate, { desc = '[D]ebug [K]ill' })
      
      -- DAP UI keymaps
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug [U]I toggle' })
      vim.keymap.set('n', '<leader>de', dapui.eval, { desc = '[D]ebug [E]val' })
      vim.keymap.set('v', '<leader>de', dapui.eval, { desc = '[D]ebug [E]val' })
    end,
  },
}