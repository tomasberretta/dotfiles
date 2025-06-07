-- Helps select and manage Python virtual environments within Neovim.
return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
  version = '*',
  keys = {
    { '<leader>vc', '<cmd>VenvSelect<cr>', desc = '[V]env [C]hoose' },
    { '<leader>vs', '<cmd>VenvSelectCached<cr>', desc = '[V]env [S]elect' },
  },
  opts = {
    -- Configure venv-selector to find your environments
    name = { '.venv', 'venv' },
    poetry = true,
    search_paths = { vim.fn.expand '~/.local/share/virtualenvs' },

    -- Automatically update LSP servers when a new environment is selected
    on_select = function(_python_path)
      -- Notify pyright
      local pyright_clients = vim.lsp.get_clients { name = 'pyright' }
      if #pyright_clients > 0 then
        pyright_clients[1].notify('workspace/didChangeConfiguration', {})
      end

      -- Notify ruff
      local ruff_clients = vim.lsp.get_clients { name = 'ruff' }
      if #ruff_clients > 0 then
        ruff_clients[1].notify('workspace/didChangeConfiguration', {})
      end
    end,
  },
} 