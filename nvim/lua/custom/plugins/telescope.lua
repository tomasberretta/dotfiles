-- =============================================================================
-- TELESCOPE - FUZZY FINDING
-- =============================================================================
-- All search/find operations under <leader>f

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
          find_files = { hidden = true },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- Find files
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind recent [.]' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find files' })

      -- Find text
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Search in buffer' })

      -- Find help/meta
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fR', builtin.resume, { desc = '[F]ind [R]esume' })

      -- Find in open files
      vim.keymap.set('n', '<leader>fo', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Grep in Open Files',
        }
      end, { desc = '[F]ind in [O]pen files' })

      -- Find neovim config
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config', hidden = true }
      end, { desc = '[F]ind [N]eovim config' })

      -- Find messages
      vim.keymap.set('n', '<leader>fm', function()
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
            attach_mappings = function(prompt_bufnr, _)
              actions.select_default:replace(function()
                local entry = require('telescope.actions.state').get_selected_entry()
                if entry and entry.value then
                  vim.fn.setreg('+', entry.value)
                  vim.notify('Copied to clipboard')
                end
                actions.close(prompt_bufnr)
              end)
              return true
            end,
          })
          :find()
      end, { desc = '[F]ind [M]essages' })

      -- Find & Replace (Spectre)
      vim.keymap.set('n', '<leader>fr', function()
        require('spectre').toggle()
      end, { desc = '[F]ind & [R]eplace' })
    end,
  },
}
