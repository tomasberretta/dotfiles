return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        --
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          -- Configure to show hidden files
          file_ignore_patterns = { '%.git/', 'node_modules/', '%.DS_Store' },
          -- mappings = {
          --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          -- },
        },
        pickers = {
          find_files = {
            -- Show hidden files (dotfiles)
            hidden = true,
            -- Optionally also show files in .git directories (usually not wanted)
            -- no_ignore = true,
            -- Optionally ignore .gitignore files
            -- no_ignore_parent = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>sm', function()
        local telescope = require 'telescope'
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
              -- Overwrite default action to yank message and close
              actions.select_default:replace(function()
                local entry = require('telescope.actions.state').get_selected_entry()
                if entry and entry.value then
                  vim.fn.setreg('+', entry.value)
                  vim.notify('Yanked message to system clipboard', vim.log.levels.INFO)
                end
                actions.close(prompt_bufnr)
              end)
              return true
            end,
          })
          :find()
      end, { desc = '[S]earch [M]essages' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config', hidden = true }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "[A]dd File" },
      { "<leader>he", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "[E]xplorer" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to File 5" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = { "BufReadPost *.md", "BufNewFile *.md" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = function()
      local cmp_ok, cmp = pcall(require, "cmp")
      local obsidian_opts = {
        workspaces = {
          {
            name = "tomas-vault",
            path = "/Users/tomiberretta/Library/Mobile Documents/iCloud~md~obsidian/Documents/tomas - mobile",
          },
          {
            name = "Personal",
            path = "~/Documents/Obsidian/Personal",
          },
        },
        new_notes_location = "notes",
        keys = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true, desc = "[O]bsidian: [G]oto [F]ile" },
          },
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true, desc = "[O]bsidian: Toggle [C]heckbox [H]ere" },
          },
          ["<leader>o"] = {
            action = function()
              return require("obsidian").util.open_in_os()
            end,
            opts = { buffer = true, desc = "[O]bsidian: [O]pen in OS" },
          },
        },
        new_note_location = "notes_subdir",
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            for _ = 1, 4 do
              suffix = tostring(os.time()) .. "-" .. string.char(math.random(65, 90))
            end
          end
          return suffix
        end,
        disable_frontmatter = true,
        daily_notes = {
          folder = "daily",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d, %Y",
          template = nil,
        },
        completion = {
          nvim_cmp = cmp_ok,
          min_chars = 2,
        },
      }
      return obsidian_opts
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
    version = '*',
    keys = {
      { '<leader>vc', '<cmd>VenvSelect<cr>', desc = '[V]env [C]hoose' },
      { '<leader>vs', '<cmd>VenvSelectCached<cr>', desc = '[V]env [S]elect' },
    },
    opts = {
      name = { '.venv', 'venv' },
      poetry = true,
      search_paths = { vim.fn.expand '~/.local/share/virtualenvs' },
      on_select = function(_python_path)
        local pyright_clients = vim.lsp.get_clients { name = 'pyright' }
        if #pyright_clients > 0 then
          pyright_clients[1].notify('workspace/didChangeConfiguration', {})
        end
        local ruff_clients = vim.lsp.get_clients { name = 'ruff' }
        if #ruff_clients > 0 then
          ruff_clients[1].notify('workspace/didChangeConfiguration', {})
        end
      end,
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { '<leader>fs', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = '[F]lash [S]earch' },
      { '<leader>fr', mode = { 'n', 'o', 'x' }, function() require('flash').remote() end, desc = '[F]lash [R]emote Search' },
      { '<leader>ft', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = '[F]lash [T]reesitter Jump' },
      { '<leader>fT', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = '[F]lash [T]reesitter Search' },
      { '<leader>fo', mode = { 'c' }, function() require('flash').toggle() end, desc = '[F]lash [O]ptions' },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
      "preservim/vim-pencil",
    },
    config = function()
      require("zen-mode").setup({
        window = {
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          twilight = {
            enabled = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>tz", function()
        require("zen-mode").toggle()
      end, { noremap = true, silent = true, desc = "[Z]en Mode" })
      vim.keymap.set("n", "<leader>tt", function()
        require("twilight").toggle()
      end, { noremap = true, silent = true, desc = "[T]wilight" })
      vim.keymap.set("n", "<leader>tp", function()
        vim.cmd("PencilToggle")
      end, { noremap = true, silent = true, desc = "[P]encil Mode" })
      vim.keymap.set("n", "<leader>ts", function()
        vim.opt.spell = not vim.opt.spell:get()
      end, { noremap = true, silent = true, desc = "[S]pell Check" })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' })
        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
        vim.keymap.set('n', ']h', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Next Hunk' })
        vim.keymap.set('n', '[h', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Prev Hunk' })
        local gitsigns = require 'gitsigns'
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'git show [D]eleted' })
      end,
    },
  },
}
