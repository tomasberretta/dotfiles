-- =============================================================================
-- TELESCOPE - FUZZY FINDING
-- =============================================================================
-- Fuzzy finding for files, text, symbols, and more
-- Keybinding prefix: <leader>s for [S]earch

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { '%.git/', 'node_modules/', '%.DS_Store' },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Keymaps
      local builtin = require 'telescope.builtin'
      
      -- Files
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch recent files ([.])' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
      
      -- Text
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Search in current buffer' })
      
      -- Vim
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[S]earch [R]esume' })
      
      -- Special
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in open files' })
      
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config', hidden = true }
      end, { desc = '[S]earch [N]eovim config' })
      
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Custom messages search
      vim.keymap.set('n', '<leader>sm', function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local actions = require 'telescope.actions'
        local conf = require('telescope.config').values

        local temp_file = vim.fn.tempname()
        vim.cmd('redir! > ' .. temp_file)
        vim.cmd 'silent messages'
        vim.cmd 'redir END'
        local messages = vim.fn.readfile(temp_file)
        vim.fn.delete(temp_file)

        pickers
          .new({}, {
            prompt_title = 'Neovim Messages',
            finder = finders.new_table { results = messages },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                local entry = require('telescope.actions.state').get_selected_entry()
                if entry and entry.value then
                  vim.fn.setreg('+', entry.value)
                  vim.notify('Yanked message to clipboard', vim.log.levels.INFO)
                end
                actions.close(prompt_bufnr)
              end)
              return true
            end,
          })
          :find()
      end, { desc = '[S]earch [M]essages' })
    end,
  },
}