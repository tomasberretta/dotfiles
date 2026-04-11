local M = {}

M.common_rules = {
  max_line_length = 120,
  indent_size = 2,
  use_tabs = false,
  trim_trailing_whitespace = true,
}

M.formatters_by_ft = {
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  javascriptreact = { 'prettier' },
  typescriptreact = { 'prettier' },
  json = { 'prettier' },
  jsonc = { 'prettier' },
  yaml = { 'prettier' },
  markdown = { 'prettier' },
  html = { 'prettier' },
  css = { 'prettier' },
  scss = { 'prettier' },
  graphql = { 'prettier' },
  vue = { 'prettier' },
  svelte = { 'prettier' },
  go = { 'goimports', 'gofumpt' },
  rust = { 'rustfmt' },
  sh = { 'shfmt' },
  bash = { 'shfmt' },
  fish = { 'fish_indent' },
  toml = { 'taplo' },
  terraform = { 'terraform_fmt' },
  tf = { 'terraform_fmt' },
  dockerfile = { 'hadolint' },
  sql = { 'sql_formatter' },
  xml = { 'xmllint' },
}

M.formatters = {
  black = {
    command = function()
      local venv = vim.env.VIRTUAL_ENV
      if venv then
        return venv .. '/bin/black'
      end
      return 'black'
    end,
    prepend_args = { '--fast', '--line-length', '88' },
  },
  isort = {
    command = function()
      local venv = vim.env.VIRTUAL_ENV
      if venv then
        return venv .. '/bin/isort'
      end
      return 'isort'
    end,
  },
  shfmt = {
    prepend_args = { '-i', '2', '-ci' },
  },
}

return M
