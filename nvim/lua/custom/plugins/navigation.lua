-- =============================================================================
-- NAVIGATION & FILE MANAGEMENT
-- =============================================================================
-- Neo-tree: \, Yazi: <leader>y, Harpoon: <leader>h, Flash: s/S (no leader)

return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
        -- `grealpath` is not on PATH (ships with brew `coreutils`); disable this shortcut
        copy_relative_path_to_selected_files = false,
      },
    },
    keys = {
      { '<leader>y', '<cmd>Yazi<cr>', desc = '[Y]azi' },
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '\\', '<cmd>Neotree toggle<cr>', desc = 'File explorer' },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_hidden = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 34,
        mappings = {
          ['<space>'] = 'none',
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = false,
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          default = '',
        },
        modified = { symbol = '' },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
      },
      source_selector = {
        winbar = false,
        statusline = false,
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)
      -- NeoTree highlights are painted by custom.theme so they follow the palette.

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = function()
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.cursorlineopt = 'line'
        end,
      })
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = '[H]arpoon [A]dd',
      },
      {
        '<leader>hh',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = '[H]arpoon menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'Harpoon 5',
      },
      {
        '<leader>hn',
        function()
          require('harpoon'):list():next()
        end,
        desc = '[H]arpoon [N]ext',
      },
      {
        '<leader>hp',
        function()
          require('harpoon'):list():prev()
        end,
        desc = '[H]arpoon [P]rev',
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = { uppercase = true, rainbow = { enabled = false } },
      highlight = { backdrop = true, matches = true },
      jump = { pos = 'start' },
      modes = {
        search = { enabled = true },
        char = { enabled = true, highlight = { backdrop = true }, jump_labels = true },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Flash remote',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Flash treesitter search',
      },
    },
  },
}
