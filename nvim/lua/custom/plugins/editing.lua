-- =============================================================================
-- CODE EDITING & REFACTORING
-- =============================================================================
-- Refactoring under <leader>c (Code), Notes/HTTP under <leader>u (Utils)

return {
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    opts = {
      mappings = {
        left = '<A-h>',
        right = '<A-l>',
        down = '<A-j>',
        up = '<A-k>',
        line_left = '',
        line_right = '',
        line_down = '<A-j>',
        line_up = '<A-k>',
      },
    },
  },

  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
    init = function()
      -- Disable VM's `\\`-prefixed default bindings; they shadow `\` (Neo-tree) and cause a keypress delay.
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        ['Add Cursor Down'] = '<C-A-j>',
        ['Add Cursor Up'] = '<C-A-k>',
      }
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {}
      pcall(function()
        require('telescope').load_extension 'refactoring'
      end)
    end,
    keys = {
      {
        '<leader>ce',
        function()
          require('refactoring').refactor 'Extract Function'
        end,
        desc = '[C]ode: [E]xtract function',
        mode = 'x',
      },
      {
        '<leader>cE',
        function()
          require('refactoring').refactor 'Extract Function To File'
        end,
        desc = '[C]ode: [E]xtract to file',
        mode = 'x',
      },
      {
        '<leader>cv',
        function()
          require('refactoring').refactor 'Extract Variable'
        end,
        desc = '[C]ode: extract [V]ariable',
        mode = 'x',
      },
      {
        '<leader>cI',
        function()
          require('refactoring').refactor 'Inline Variable'
        end,
        desc = '[C]ode: [I]nline variable',
        mode = { 'n', 'x' },
      },
      {
        '<leader>cb',
        function()
          require('refactoring').refactor 'Extract Block'
        end,
        desc = '[C]ode: extract [B]lock',
        mode = 'n',
      },
      {
        '<leader>cB',
        function()
          require('refactoring').refactor 'Extract Block To File'
        end,
        desc = '[C]ode: [B]lock to file',
        mode = 'n',
      },
      {
        '<leader>cq',
        function()
          require('telescope').extensions.refactoring.refactors()
        end,
        desc = '[C]ode: refactor [Q]uick menu',
        mode = { 'n', 'x' },
      },
    },
  },

  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
  },

  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = { n_lines = 500 },
  },

  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment block' },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false,
      },
      disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = 0,
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Notes under <leader>u (Utils)
  {
    'JellyApple102/flote.nvim',
    config = function()
      require('flote').setup {
        q_to_quit = true,
        window_style = 'minimal',
        window_border = 'rounded',
        window_title = true,
        notes_dir = vim.fn.stdpath 'data' .. '/flote',
        files = {
          global = 'flote-global.md',
          cwd = function()
            return vim.fn.getcwd():gsub('/', '_') .. '.md'
          end,
        },
      }
    end,
    keys = {
      { '<leader>un', '<cmd>Flote<cr>', desc = '[U]tils: [N]otes' },
      { '<leader>uN', '<cmd>Flote global<cr>', desc = '[U]tils: [N]otes global' },
    },
  },

  -- HTTP Client under <leader>u (Utils)
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    config = function()
      require('kulala').setup {
        split_direction = 'vertical',
        default_view = 'headers_body',
        debug = false,
        contenttypes = {
          ['application/json'] = {
            formatter = { 'jq', '.' },
            pathresolver = require('kulala.parser.jsonpath').parse,
          },
          ['application/xml'] = {
            formatter = { 'xmllint', '--format', '-' },
            pathresolver = { 'xmllint', '--xpath', '{{path}}', '-' },
          },
          ['text/html'] = {
            formatter = { 'xmllint', '--format', '--html', '-' },
            pathresolver = {},
          },
        },
        show_icons = 'on_request',
        icons = {
          inlay = { loading = '⏳', done = '✅', error = '❌' },
          lualine = '🐼',
        },
        additional_curl_options = {},
        scratchpad_default_contents = {
          '@host = http://localhost:8080',
          '',
          '# @name my_request',
          'GET {{host}}/api/users HTTP/1.1',
          'Content-Type: application/json',
          'Authorization: Bearer {{token}}',
          '',
        },
      }
    end,
    keys = {
      {
        '<leader>uh',
        function()
          require('kulala').run()
        end,
        desc = '[U]tils: [H]TTP run',
      },
      {
        '<leader>uH',
        function()
          require('kulala').run_all()
        end,
        desc = '[U]tils: [H]TTP run all',
      },
      {
        '<leader>us',
        function()
          local buf_name = vim.fn.expand '%:t'
          if buf_name == 'kulala-scratchpad.http' then
            vim.cmd 'bd'
          else
            require('kulala').scratchpad()
          end
        end,
        desc = '[U]tils: HTTP [S]cratchpad',
      },
    },
  },
}
