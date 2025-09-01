return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>f', group = '[F]ind' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>g', group = '[G]it' },
        { '<leader>j', group = '[J]ujutsu' },
        { '<leader>r', group = '[R]un' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>x', group = 'Toggle [X]' },
        { '<leader>u', group = '[U]tils' },
        { '<leader>a', group = '[A]I' },
      },
    },
  },

  {
    'Yazeed1s/minimal.nvim',
    priority = 1000,
    config = function()
      require('custom.theme').setup()
    end,
  },

  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 999,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local custom_theme = {
        normal = {
          a = { bg = '#7EB7E6', fg = '#191B20', gui = 'bold' },
          b = { bg = '#3A3D4A', fg = '#DFE0EA' },
          c = { bg = '#272932', fg = '#DFE0EA' },
        },
        insert = {
          a = { bg = '#94DD8E', fg = '#191B20', gui = 'bold' },
          b = { bg = '#3A3D4A', fg = '#DFE0EA' },
          c = { bg = '#272932', fg = '#DFE0EA' },
        },
        visual = {
          a = { bg = '#D895C7', fg = '#191B20', gui = 'bold' },
          b = { bg = '#3A3D4A', fg = '#DFE0EA' },
          c = { bg = '#272932', fg = '#DFE0EA' },
        },
        replace = {
          a = { bg = '#E85A84', fg = '#191B20', gui = 'bold' },
          b = { bg = '#3A3D4A', fg = '#DFE0EA' },
          c = { bg = '#272932', fg = '#DFE0EA' },
        },
        command = {
          a = { bg = '#F9E154', fg = '#191B20', gui = 'bold' },
          b = { bg = '#3A3D4A', fg = '#DFE0EA' },
          c = { bg = '#272932', fg = '#DFE0EA' },
        },
        inactive = {
          a = { bg = '#272932', fg = '#515669', gui = 'bold' },
          b = { bg = '#272932', fg = '#515669' },
          c = { bg = '#191B20', fg = '#515669' },
        },
      }

      local custom_theme_light = {
        normal = {
          a = { bg = '#4d7bd6', fg = '#f4f4f4', gui = 'bold' },
          b = { bg = '#e8f2ff', fg = '#2c2c2c' },
          c = { bg = '#f0f0f0', fg = '#2c2c2c' },
        },
        insert = {
          a = { bg = '#52a065', fg = '#f4f4f4', gui = 'bold' },
          b = { bg = '#e8f2ff', fg = '#2c2c2c' },
          c = { bg = '#f0f0f0', fg = '#2c2c2c' },
        },
        visual = {
          a = { bg = '#9575cd', fg = '#f4f4f4', gui = 'bold' },
          b = { bg = '#e8f2ff', fg = '#2c2c2c' },
          c = { bg = '#f0f0f0', fg = '#2c2c2c' },
        },
        replace = {
          a = { bg = '#e57373', fg = '#f4f4f4', gui = 'bold' },
          b = { bg = '#e8f2ff', fg = '#2c2c2c' },
          c = { bg = '#f0f0f0', fg = '#2c2c2c' },
        },
        command = {
          a = { bg = '#ffb74d', fg = '#2c2c2c', gui = 'bold' },
          b = { bg = '#e8f2ff', fg = '#2c2c2c' },
          c = { bg = '#f0f0f0', fg = '#2c2c2c' },
        },
        inactive = {
          a = { bg = '#f0f0f0', fg = '#7a7a7a', gui = 'bold' },
          b = { bg = '#f0f0f0', fg = '#7a7a7a' },
          c = { bg = '#f4f4f4', fg = '#7a7a7a' },
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = vim.o.background == 'light' and custom_theme_light or custom_theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = {}, winbar = {} },
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.defer_fn(function()
            local theme = vim.o.background == 'light' and custom_theme_light or custom_theme
            require('lualine').setup { options = { theme = theme } }
          end, 1)
        end,
      })
    end,
  },
}
