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
      -- IntelliJ New UI Dark: flat, minimal status bar
      -- Entire bar is surface bg with subtle text, no powerline separators
      local ij_dark = {
        normal = {
          a = { bg = '#2b2d30', fg = '#56a8f5', gui = 'bold' },
          b = { bg = '#2b2d30', fg = '#bcbec4' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
        insert = {
          a = { bg = '#2b2d30', fg = '#6aab73', gui = 'bold' },
          b = { bg = '#2b2d30', fg = '#bcbec4' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
        visual = {
          a = { bg = '#2b2d30', fg = '#c77dbb', gui = 'bold' },
          b = { bg = '#2b2d30', fg = '#bcbec4' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
        replace = {
          a = { bg = '#2b2d30', fg = '#f75464', gui = 'bold' },
          b = { bg = '#2b2d30', fg = '#bcbec4' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
        command = {
          a = { bg = '#2b2d30', fg = '#cf8e6d', gui = 'bold' },
          b = { bg = '#2b2d30', fg = '#bcbec4' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
        inactive = {
          a = { bg = '#2b2d30', fg = '#6f737a' },
          b = { bg = '#2b2d30', fg = '#6f737a' },
          c = { bg = '#2b2d30', fg = '#6f737a' },
        },
      }

      local ij_light = {
        normal = {
          a = { bg = '#eef0f3', fg = '#0065cf', gui = 'bold' },
          b = { bg = '#eef0f3', fg = '#080808' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
        insert = {
          a = { bg = '#eef0f3', fg = '#067d17', gui = 'bold' },
          b = { bg = '#eef0f3', fg = '#080808' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
        visual = {
          a = { bg = '#eef0f3', fg = '#871094', gui = 'bold' },
          b = { bg = '#eef0f3', fg = '#080808' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
        replace = {
          a = { bg = '#eef0f3', fg = '#cf3737', gui = 'bold' },
          b = { bg = '#eef0f3', fg = '#080808' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
        command = {
          a = { bg = '#eef0f3', fg = '#cf6a21', gui = 'bold' },
          b = { bg = '#eef0f3', fg = '#080808' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
        inactive = {
          a = { bg = '#eef0f3', fg = '#8c8c8c' },
          b = { bg = '#eef0f3', fg = '#8c8c8c' },
          c = { bg = '#eef0f3', fg = '#8c8c8c' },
        },
      }

      -- Thin separator matching IntelliJ border
      local separator = { left = '', right = '' }

      -- LSP client name (like IntelliJ shows SDK/language server)
      local function lsp_name()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if #clients == 0 then
          return ''
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return ' ' .. table.concat(names, ', ')
      end

      -- Indentation info (like IntelliJ "Spaces: 2" / "Tabs: 4")
      local function indent_info()
        if vim.bo.expandtab then
          return 'Spaces: ' .. vim.bo.shiftwidth
        else
          return 'Tabs: ' .. vim.bo.tabstop
        end
      end

      -- Line ending format
      local function line_ending()
        local format = vim.bo.fileformat
        if format == 'unix' then return 'LF'
        elseif format == 'dos' then return 'CRLF'
        else return 'CR'
        end
      end

      -- Breadcrumb: file > treesitter context (class > function)
      local function breadcrumb()
        local filepath = vim.fn.expand '%:~:.'
        if filepath == '' then return '' end

        local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
        if not ok then return filepath end

        local node = ts_utils.get_node_at_cursor()
        local parts = {}
        while node do
          local type = node:type()
          if type == 'function_declaration' or type == 'function_definition'
              or type == 'method_declaration' or type == 'method_definition'
              or type == 'function_item' then
            local name_node = node:field('name')[1]
            if name_node then
              table.insert(parts, 1, ' ' .. vim.treesitter.get_node_text(name_node, 0))
            end
          elseif type == 'class_declaration' or type == 'class_definition'
              or type == 'struct_item' or type == 'impl_item' then
            local name_node = node:field('name')[1]
            if name_node then
              table.insert(parts, 1, ' ' .. vim.treesitter.get_node_text(name_node, 0))
            end
          end
          node = node:parent()
        end

        if #parts > 0 then
          return filepath .. '  ' .. table.concat(parts, ' > ')
        end
        return filepath
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = vim.o.background == 'light' and ij_light or ij_dark,
          component_separators = { left = '│', right = '│' },
          section_separators = separator,
          disabled_filetypes = { statusline = {}, winbar = {} },
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { { 'mode', fmt = function(s) return s:sub(1, 1) end } },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { breadcrumb } },
          lualine_x = { lsp_name, 'filetype', indent_info, { 'encoding', fmt = string.upper }, line_ending },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
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
