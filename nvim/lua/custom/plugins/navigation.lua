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
      keymaps = { show_help = '<f1>' },
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
        width = 38,
        mappings = {
          ['<space>'] = 'none',
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 3,
          padding = 2,
          with_markers = false,
          with_expanders = true,
          expander_collapsed = '❯',
          expander_expanded = '⌄',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '󰉋',
          folder_open = '󰝰',
          folder_empty = '󰉋',
          default = '󰈔',
        },
        modified = { symbol = '' },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = false,
        },
      },
      source_selector = {
        winbar = false,
        statusline = false,
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)

      -- IntelliJ-style highlights for neo-tree
      vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = '#1e1f22', fg = '#bcbec4' })
      vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = '#1e1f22', fg = '#bcbec4' })
      vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = '#1e1f22', fg = '#1e1f22' })
      vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { bg = '#1e1f22', fg = '#393b40' })
      vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', { bg = '#393b40' })
      vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = '#bcbec4' })
      vim.api.nvim_set_hl(0, 'NeoTreeDirectoryIcon', { fg = '#6f937a' })
      vim.api.nvim_set_hl(0, 'NeoTreeFileName', { fg = '#bcbec4' })
      vim.api.nvim_set_hl(0, 'NeoTreeRootName', { fg = '#bcbec4', bold = true })
      vim.api.nvim_set_hl(0, 'NeoTreeExpander', { fg = '#6f737a' })
      vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', { fg = '#393b40' })
      vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { bg = '#1e1f22', fg = '#393b40' })
      vim.api.nvim_set_hl(0, 'NeoTreeTitleBar', { bg = '#1e1f22', fg = '#bcbec4', bold = true })
      vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = '#6aab73' })
      vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#56a8f5' })
      vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = '#f75464' })
      vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#cf8e6d' })

      -- Hide signcolumn in neo-tree to remove the blue bar on selection
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
