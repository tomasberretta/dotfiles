local utils = require('custom.dev-toolkit').utils
local M = {}

function M.json_viewer()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
    if text == '' then
      text = utils.get_input 'Enter JSON to view: '
    end
  end

  if text == '' then
    vim.notify('No JSON text provided', vim.log.levels.WARN)
    return
  end

  local ok, parsed = pcall(vim.fn.json_decode, text)

  if not ok then
    vim.notify('Invalid JSON: ' .. parsed, vim.log.levels.ERROR)
    return
  end

  local formatted = vim.fn.json_encode(parsed)
  formatted = formatted:gsub(',', ',\n'):gsub('{', '{\n  '):gsub('}', '\n}'):gsub('%[', '[\n  '):gsub('%]', '\n]')

  local lines = vim.split(formatted, '\n')
  local indented_lines = {}
  local indent_level = 0

  for _, line in ipairs(lines) do
    if line:match '^%s*[}%]]' then
      indent_level = math.max(0, indent_level - 1)
    end

    table.insert(indented_lines, string.rep('  ', indent_level) .. line:gsub('^%s*', ''))

    if line:match '[{%[]%s*$' then
      indent_level = indent_level + 1
    end
  end

  utils.create_floating_window(indented_lines, {
    title = 'JSON Viewer',
    filetype = 'json',
  })
end

function M.case_converter()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = utils.get_input 'Enter text to convert: '
  end

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local conversions = {
    'Original: ' .. text,
    '',
    'UPPERCASE: ' .. string.upper(text),
    'lowercase: ' .. string.lower(text),
    'Title Case: ' .. text:gsub("(%a)([%w_']*)", function(first, rest)
      return string.upper(first) .. string.lower(rest)
    end),
    'camelCase: ' .. text
      :gsub('%W+(%w)', function(c)
        return string.upper(c)
      end)
      :gsub('^%u', string.lower),
    'PascalCase: ' .. text
      :gsub('%W+(%w)', function(c)
        return string.upper(c)
      end)
      :gsub('^%l', string.upper),
    'snake_case: ' .. text:gsub('%W+', '_'):gsub('([a-z])([A-Z])', '%1_%2'):lower(),
    'SCREAMING_SNAKE_CASE: ' .. text:gsub('%W+', '_'):gsub('([a-z])([A-Z])', '%1_%2'):upper(),
    'kebab-case: ' .. text:gsub('%W+', '-'):gsub('([a-z])([A-Z])', '%1-%2'):lower(),
    'dot.case: ' .. text:gsub('%W+', '.'):gsub('([a-z])([A-Z])', '%1.%2'):lower(),
  }

  utils.create_floating_window(conversions, {
    title = 'Case Converter',
  })
end

function M.text_diff()
  local text1 = utils.get_input 'Enter first text: '
  local text2 = utils.get_input 'Enter second text: '

  if text1 == '' or text2 == '' then
    vim.notify('Both texts are required', vim.log.levels.WARN)
    return
  end

  local lines1 = vim.split(text1, '\n')
  local lines2 = vim.split(text2, '\n')

  local diff_lines = { '=== TEXT COMPARISON ===', '' }
  table.insert(diff_lines, '--- Text 1 ---')
  for i, line in ipairs(lines1) do
    table.insert(diff_lines, string.format('%3d: %s', i, line))
  end

  table.insert(diff_lines, '')
  table.insert(diff_lines, '+++ Text 2 +++')
  for i, line in ipairs(lines2) do
    table.insert(diff_lines, string.format('%3d: %s', i, line))
  end

  table.insert(diff_lines, '')
  table.insert(diff_lines, '=== DIFFERENCES ===')

  local max_lines = math.max(#lines1, #lines2)
  for i = 1, max_lines do
    local line1 = lines1[i] or ''
    local line2 = lines2[i] or ''

    if line1 ~= line2 then
      table.insert(diff_lines, string.format('Line %d:', i))
      table.insert(diff_lines, string.format('  - %s', line1))
      table.insert(diff_lines, string.format('  + %s', line2))
    end
  end

  utils.create_floating_window(diff_lines, {
    title = 'Text Diff',
    filetype = 'diff',
  })
end

function M.token_counter()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
    if text == '' then
      text = utils.get_input 'Enter text to count: '
    end
  end

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local chars = #text
  local chars_no_spaces = #text:gsub('%s', '')
  local words = #vim.split(text, '%s+')
  local lines = #vim.split(text, '\n')
  local sentences = #text:gsub('[.!?]+', '|'):split '|'
  local paragraphs = #text:gsub('\n\n+', '|'):split '|'

  local approx_tokens = math.ceil(chars / 4)

  local stats = {
    '📊 Text Statistics',
    '',
    'Characters (with spaces): ' .. chars,
    'Characters (no spaces): ' .. chars_no_spaces,
    'Words: ' .. words,
    'Lines: ' .. lines,
    'Sentences (approx): ' .. sentences,
    'Paragraphs (approx): ' .. paragraphs,
    '',
    '🤖 Token Estimation',
    'Approximate tokens: ' .. approx_tokens .. ' (chars/4)',
    '',
    'Note: Token count is approximate.',
    'Actual token count varies by model and encoding.',
  }

  utils.create_floating_window(stats, {
    title = 'Token Counter',
  })
end

function M.markdown_preview()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
    if text == '' then
      text = utils.get_input 'Enter Markdown text: '
    end
  end

  if text == '' then
    vim.notify('No markdown text provided', vim.log.levels.WARN)
    return
  end

  local processed = text
    :gsub('#+ (.-)\n', function(title)
      return '🔸 ' .. string.upper(title) .. '\n' .. string.rep('=', #title + 2) .. '\n'
    end)
    :gsub('%*%*(.-)%*%*', '【%1】')
    :gsub('%*(.-)%*', '‹%1›')
    :gsub('`(.-)`', '⟪%1⟫')
    :gsub('%[(.-)%]%((.-)%)', '%1 → %2')
    :gsub('^%- ', '• ')
    :gsub('\n%- ', '\n• ')
    :gsub('^%d+%. ', '1. ')
    :gsub('\n%d+%. ', '\n1. ')

  local lines = vim.split(processed, '\n')
  table.insert(lines, 1, '📝 Markdown Preview')
  table.insert(lines, 2, string.rep('━', 50))
  table.insert(lines, 3, '')

  utils.create_floating_window(lines, {
    title = 'Markdown Preview',
    filetype = 'markdown',
  })
end

return M

