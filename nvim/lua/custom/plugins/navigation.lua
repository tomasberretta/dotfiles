-- =============================================================================
-- NAVIGATION & FILE MANAGEMENT
-- =============================================================================
-- File exploration, project navigation, and bookmarking
-- Keybinding prefixes: <leader>e for [E]xplore, <leader>h for [H]arpoon

return {
  -- Oil: Edit filesystem like a buffer
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false, -- Required for default_file_explorer
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      use_default_keymaps = true,
      float = {
        padding = 2,
        max_width = 0.9,
        max_height = 0.9,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
    },
    keys = {
      { '<leader>e', '<cmd>Oil<cr>', desc = '[E]xplore files' },
      { '<leader>E', '<cmd>Oil --float<cr>', desc = '[E]xplore files (float)' },
      { '\\', '<cmd>Oil<cr>', desc = 'File explorer' },
    },
  },

  -- Harpoon: Quick file bookmarking
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
        desc = '[H]arpoon [A]dd file',
      },
      {
        '<leader>he',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = '[H]arpoon [E]xplorer',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon file 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'Harpoon file 5',
      },
    },
  },

  -- Flash: Fast in-file navigation
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = {
        uppercase = true,
        rainbow = {
          enabled = false,
        },
      },
      highlight = {
        backdrop = true,
        matches = true,
      },
      jump = {
        pos = 'start',
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          highlight = { backdrop = true },
          jump_labels = true,
        },
      },
    },
    keys = {
      -- Quick access with 's' (most common use)
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash jump',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash treesitter',
      },
      -- Original keybindings under <leader>f
      {
        '<leader>fs',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = '[F]lash [S]earch',
      },
      {
        '<leader>ft',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = '[F]lash [T]reesitter',
      },
      {
        '<leader>fr',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').remote()
        end,
        desc = '[F]lash [R]emote',
      },
      {
        '<leader>fT',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = '[F]lash [T]reesitter search',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote flash',
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