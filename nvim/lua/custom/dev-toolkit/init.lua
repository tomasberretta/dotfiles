local M = {}

local function create_floating_window(content, opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  if type(content) == 'string' then
    local lines = vim.split(content, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  elseif type(content) == 'table' then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  end

  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = opts.title or 'Dev Toolkit',
    title_pos = 'center',
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  vim.bo[buf].modifiable = opts.modifiable ~= false
  vim.bo[buf].filetype = opts.filetype or 'text'

  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf })

  return buf, win
end

local function get_visual_selection()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  if #lines == 0 then
    return ''
  elseif #lines == 1 then
    return string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return table.concat(lines, '\n')
  end
end

local function get_input(prompt, default)
  return vim.fn.input(prompt, default or '')
end

function M.menu()
  local menu_items = {
    '📄 Text & Content Tools',
    '  j - JSON Viewer',
    '  c - Case Converter',
    '  d - Text Diff',
    '  t - Token Counter',
    '  m - Markdown Preview',
    '',
    '🔄 Encoding & Conversion',
    '  b - Base64 Converter',
    '  u - URL Encoder',
    '  n - Number Base Converter',
    '  C - CSV/JSON Converter',
    '',
    '🛠  Generators & Utilities',
    '  U - UUID Generator',
    '  q - QR Code Generator',
    '  h - Hash Generator',
    '  l - Lorem Generator',
    '  T - Timestamp',
    '  p - Color Palette',
    '',
    '⚡ Development Tools',
    '  J - JWT Decoder',
    '  s - SQL Formatter',
    '  r - Regex Generator',
    '  k - Cron Calculator',
    '',
    'Press any key to select, q/Esc to quit',
  }

  create_floating_window(menu_items, {
    title = 'Dev Toolkit Menu',
    width = 50,
    height = #menu_items + 2,
    modifiable = false,
  })
end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command('DevToolkit', function()
    M.menu()
  end, {})
end

M.utils = {
  create_floating_window = create_floating_window,
  get_visual_selection = get_visual_selection,
  get_input = get_input,
}

return M

