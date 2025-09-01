return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          -- Code actions (<leader>c)
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'v' })
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
          map('<leader>cf', function()
            require('conform').format { async = true, lsp_format = 'fallback' }
          end, '[C]ode [F]ormat')

          -- Code navigation
          map('<leader>cd', require('telescope.builtin').lsp_definitions, '[C]ode [D]efinition')
          map('<leader>cD', vim.lsp.buf.declaration, '[C]ode [D]eclaration')
          map('<leader>ci', require('telescope.builtin').lsp_implementations, '[C]ode [I]mplementation')
          map('<leader>ct', require('telescope.builtin').lsp_type_definitions, '[C]ode [T]ype')
          map('<leader>cR', require('telescope.builtin').lsp_references, '[C]ode [R]eferences')
          map('<leader>cs', require('telescope.builtin').lsp_document_symbols, '[C]ode [S]ymbols')
          map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[C]ode [W]orkspace symbols')

          -- Quick navigation (no leader)
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')
          map('gD', vim.lsp.buf.declaration, 'Goto declaration')
          map('gr', require('telescope.builtin').lsp_references, 'Goto references')
          map('gi', require('telescope.builtin').lsp_implementations, 'Goto implementation')
          map('gy', require('telescope.builtin').lsp_type_definitions, 'Goto type')
          map('K', vim.lsp.buf.hover, 'Hover docs')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>xh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'markdownlint',
        'black',
        'isort',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      local formatters_config = require 'custom.formatters'

      require('conform').setup {
        notify_on_error = false,
        notify_no_formatters = false,
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          end

          local timeout = vim.bo[bufnr].filetype == 'python' and 30000 or 2000
          local conform = require 'conform'
          local formatters = conform.list_formatters(bufnr)

          if #formatters == 0 then
            local clients = vim.lsp.get_clients { bufnr = bufnr }
            local has_lsp_formatter = false
            for _, client in ipairs(clients) do
              if client.supports_method 'textDocument/formatting' then
                has_lsp_formatter = true
                break
              end
            end
            if not has_lsp_formatter then
              return nil
            end
          end

          return { timeout_ms = timeout, lsp_format = 'fallback', quiet = true }
        end,
        formatters_by_ft = formatters_config.formatters_by_ft,
        formatters = formatters_config.formatters,
      }
    end,
  },
}
