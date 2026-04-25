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
        { '<leader>b', group = '[B]uffer' },
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
      -- LSP client name (like IntelliJ shows language server in corner)
      local ignore_lsp = { ['Augment Server'] = true, augment = true, copilot = true, github_copilot = true }
      local function lsp_name()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        local names = {}
        for _, client in ipairs(clients) do
          if not ignore_lsp[client.name] then
            table.insert(names, client.name)
          end
        end
        if #names == 0 then return '' end
        return table.concat(names, ', ')
      end

      -- Indentation style (like IntelliJ "Spaces: 2" widget)
      local function indent_info()
        if vim.bo.expandtab then
          return 'Spaces: ' .. vim.bo.shiftwidth
        else
          return 'Tabs: ' .. vim.bo.tabstop
        end
      end

      -- Line ending format
      local function line_ending()
        local fmt = vim.bo.fileformat
        if fmt == 'unix' then return 'LF'
        elseif fmt == 'dos' then return 'CRLF'
        else return 'CR' end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = require('custom.theme').lualine_theme(),
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = {}, winbar = {} },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { { 'mode', fmt = function(s) return s:sub(1, 1) end } },
          lualine_b = { { 'branch', icon = '' } },
          lualine_c = { { 'filename', path = 1, symbols = { modified = ' +', readonly = ' ', unnamed = '[No Name]' } } },
          lualine_x = {
            { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }, padding = { left = 1, right = 1 } },
            { lsp_name, icon = ' ', cond = function() return #vim.lsp.get_clients { bufnr = 0 } > 0 end },
            indent_info,
            { 'encoding', fmt = string.upper },
            line_ending,
          },
          lualine_y = {},
          lualine_z = { { 'location', fmt = function(s) return vim.fn.trim(s) end } },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.defer_fn(function()
            local theme = vim.o.background == 'light' and ij_light or ij_dark
            require('lualine').setup { options = { theme = theme } }
          end, 1)
        end,
      })
    end,
  },
}
