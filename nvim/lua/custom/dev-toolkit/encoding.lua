local utils = require('custom.dev-toolkit').utils
local M = {}

local function base64_encode(str)
  local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local result = ''
  local padding = ''

  for i = 1, #str, 3 do
    local a, b, c = str:byte(i, i + 2)
    b = b or 0
    c = c or 0

    local bitmap = a * 65536 + b * 256 + c

    result = result .. chars:sub(math.floor(bitmap / 262144) + 1, math.floor(bitmap / 262144) + 1)
    result = result .. chars:sub((math.floor(bitmap / 4096) % 64) + 1, (math.floor(bitmap / 4096) % 64) + 1)
    result = result .. (i + 1 <= #str and chars:sub((math.floor(bitmap / 64) % 64) + 1, (math.floor(bitmap / 64) % 64) + 1) or '=')
    result = result .. (i + 2 <= #str and chars:sub((bitmap % 64) + 1, (bitmap % 64) + 1) or '=')
  end

  return result
end

local function base64_decode(str)
  local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local char_map = {}
  for i = 1, #chars do
    char_map[chars:sub(i, i)] = i - 1
  end

  str = str:gsub('=', '')
  local result = ''

  for i = 1, #str, 4 do
    local a = char_map[str:sub(i, i)] or 0
    local b = char_map[str:sub(i + 1, i + 1)] or 0
    local c = char_map[str:sub(i + 2, i + 2)] or 0
    local d = char_map[str:sub(i + 3, i + 3)] or 0

    local bitmap = a * 262144 + b * 4096 + c * 64 + d

    result = result .. string.char(math.floor(bitmap / 65536) % 256)
    if i + 2 <= #str then
      result = result .. string.char(math.floor(bitmap / 256) % 256)
    end
    if i + 3 <= #str then
      result = result .. string.char(bitmap % 256)
    end
  end

  return result
end

function M.base64()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = utils.get_input 'Enter text to encode/decode: '
  end

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local encoded, decoded
  local is_base64 = text:match '^[A-Za-z0-9+/]*=*$' and #text % 4 == 0

  if is_base64 then
    local ok, result = pcall(base64_decode, text)
    decoded = ok and result or 'Invalid Base64'
    encoded = text
  else
    encoded = base64_encode(text)
    decoded = text
  end

  local result = {
    '🔄 Base64 Converter',
    '',
    '📝 Original Text:',
    decoded,
    '',
    '🔑 Base64 Encoded:',
    encoded,
    '',
    'Auto-detected input as: ' .. (is_base64 and 'Base64' or 'Plain text'),
  }

  utils.create_floating_window(result, {
    title = 'Base64 Converter',
  })
end

function M.url_encode()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = utils.get_input 'Enter text/URL to encode/decode: '
  end

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local function url_encode_str(str)
    return str:gsub('[^%w%-%.%_%~]', function(c)
      return string.format('%%%02X', c:byte())
    end)
  end

  local function url_decode_str(str)
    return str
      :gsub('%%(%x%x)', function(hex)
        return string.char(tonumber(hex, 16))
      end)
      :gsub('+', ' ')
  end

  local is_encoded = text:match '%%[0-9A-Fa-f][0-9A-Fa-f]'
  local encoded, decoded

  if is_encoded then
    decoded = url_decode_str(text)
    encoded = text
  else
    encoded = url_encode_str(text)
    decoded = text
  end

  local result = {
    '🔗 URL Encoder/Decoder',
    '',
    '📝 Decoded Text:',
    decoded,
    '',
    '🔑 URL Encoded:',
    encoded,
    '',
    'Auto-detected input as: ' .. (is_encoded and 'URL Encoded' or 'Plain text'),
  }

  utils.create_floating_window(result, {
    title = 'URL Encoder',
  })
end

function M.number_base()
  local input = utils.get_input 'Enter number (prefix with 0x for hex, 0b for binary): '

  if input == '' then
    vim.notify('No number provided', vim.log.levels.WARN)
    return
  end

  local num

  if input:match '^0x' then
    num = tonumber(input:sub(3), 16)
  elseif input:match '^0b' then
    num = tonumber(input:sub(3), 2)
  else
    num = tonumber(input)
  end

  if not num then
    vim.notify('Invalid number format', vim.log.levels.ERROR)
    return
  end

  local function to_binary(n)
    if n == 0 then
      return '0'
    end
    local result = ''
    while n > 0 do
      result = (n % 2) .. result
      n = math.floor(n / 2)
    end
    return result
  end

  local result = {
    '🔢 Number Base Converter',
    '',
    'Input: ' .. input,
    '',
    'Decimal: ' .. tostring(num),
    'Hexadecimal: 0x' .. string.format('%X', num),
    'Binary: 0b' .. to_binary(num),
    'Octal: 0' .. string.format('%o', num),
    '',
    'Additional formats:',
    'Hex (lowercase): 0x' .. string.format('%x', num),
    'Scientific: ' .. string.format('%e', num),
  }

  utils.create_floating_window(result, {
    title = 'Number Base Converter',
  })
end

function M.csv_json()
  local choice = vim.fn.input 'Convert (c)sv to json or (j)son to csv? [c/j]: '

  if choice ~= 'c' and choice ~= 'j' then
    vim.notify('Invalid choice', vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = utils.get_input('Enter ' .. (choice == 'c' and 'CSV' or 'JSON') .. ' data: ')
  end

  if text == '' then
    vim.notify('No data provided', vim.log.levels.WARN)
    return
  end

  local result_lines = { '🔄 CSV ↔ JSON Converter', '' }

  if choice == 'c' then
    local lines = vim.split(text, '\n')
    if #lines < 2 then
      vim.notify('CSV needs at least header and one data row', vim.log.levels.ERROR)
      return
    end

    local headers = vim.split(lines[1], ',')
    for i, header in ipairs(headers) do
      headers[i] = header:gsub('^%s*"?', ''):gsub('"?%s*$', '')
    end

    local json_array = {}
    for i = 2, #lines do
      if lines[i]:match '%S' then
        local values = vim.split(lines[i], ',')
        local row = {}
        for j, value in ipairs(values) do
          if headers[j] then
            row[headers[j]] = value:gsub('^%s*"?', ''):gsub('"?%s*$', '')
          end
        end
        table.insert(json_array, row)
      end
    end

    local json_str = vim.fn.json_encode(json_array)
    table.insert(result_lines, '📊 Original CSV:')
    table.insert(result_lines, text)
    table.insert(result_lines, '')
    table.insert(result_lines, '📋 Converted JSON:')
    table.insert(result_lines, json_str)
  else
    local ok, data = pcall(vim.fn.json_decode, text)

    if not ok then
      vim.notify('Invalid JSON: ' .. data, vim.log.levels.ERROR)
      return
    end

    if type(data) ~= 'table' or #data == 0 then
      vim.notify('JSON must be an array of objects', vim.log.levels.ERROR)
      return
    end

    local headers = {}
    for key, _ in pairs(data[1]) do
      table.insert(headers, key)
    end

    local csv_lines = { table.concat(headers, ',') }

    for _, row in ipairs(data) do
      local values = {}
      for _, header in ipairs(headers) do
        table.insert(values, tostring(row[header] or ''))
      end
      table.insert(csv_lines, table.concat(values, ','))
    end

    table.insert(result_lines, '📋 Original JSON:')
    table.insert(result_lines, text)
    table.insert(result_lines, '')
    table.insert(result_lines, '📊 Converted CSV:')
    for _, line in ipairs(csv_lines) do
      table.insert(result_lines, line)
    end
  end

  utils.create_floating_window(result_lines, {
    title = 'CSV/JSON Converter',
  })
end

return M

