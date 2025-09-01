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
  yaml = { 'prettier' },
  markdown = { 'prettier' },
  html = { 'prettier' },
  css = { 'prettier' },
  scss = { 'prettier' },
  go = { 'gofmt' },
  rust = { 'rustfmt' },
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
  trim_whitespace = {
    format = function(_, _, lines)
      if not lines or #lines == 0 then
        return lines
      end
      
      local result = {}
      local blank_count = 0
      
      for i, line in ipairs(lines) do
        local trimmed = line:gsub('%s+$', '')
        
        if trimmed == '' then
          blank_count = blank_count + 1
        else
          if blank_count > 0 and #result > 0 then
            table.insert(result, '')
          end
          blank_count = 0
          table.insert(result, trimmed)
        end
      end
      
      return result
    end,
  },
}

return M
