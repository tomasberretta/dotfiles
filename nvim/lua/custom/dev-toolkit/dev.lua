local utils = require('custom.dev-toolkit').utils
local M = {}

function M.jwt_decoder()
  local mode = vim.fn.mode()
  local token

  if mode == 'v' or mode == 'V' then
    token = utils.get_visual_selection()
  else
    token = utils.get_input 'Enter JWT token: '
  end

  if token == '' then
    vim.notify('No JWT token provided', vim.log.levels.WARN)
    return
  end

  local parts = vim.split(token, '%.')

  if #parts ~= 3 then
    vim.notify('Invalid JWT format (should have 3 parts)', vim.log.levels.ERROR)
    return
  end

  local function base64_url_decode(str)
    str = str:gsub('%-', '+'):gsub('_', '/')
    local padding = 4 - (#str % 4)
    if padding ~= 4 then
      str = str .. string.rep('=', padding)
    end

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

      result = result .. string.char((bitmap >> 16) & 255)
      if i + 2 <= #str then
        result = result .. string.char((bitmap >> 8) & 255)
      end
      if i + 3 <= #str then
        result = result .. string.char(bitmap & 255)
      end
    end

    return result
  end

  local header_ok, header = pcall(function()
    return vim.fn.json_decode(base64_url_decode(parts[1]))
  end)

  local payload_ok, payload = pcall(function()
    return vim.fn.json_decode(base64_url_decode(parts[2]))
  end)

  local result = { '🔐 JWT Decoder', '' }

  if header_ok then
    table.insert(result, '📋 Header:')
    table.insert(result, vim.fn.json_encode(header))
    table.insert(result, '')
  else
    table.insert(result, '❌ Invalid header: ' .. tostring(header))
    table.insert(result, '')
  end

  if payload_ok then
    table.insert(result, '📄 Payload:')
    table.insert(result, vim.fn.json_encode(payload))
    table.insert(result, '')

    if payload.exp then
      local exp_date = os.date('%Y-%m-%d %H:%M:%S', payload.exp)
      local is_expired = payload.exp < os.time()
      table.insert(result, '⏰ Expires: ' .. exp_date .. (is_expired and ' (EXPIRED)' or ' (Valid)'))
    end

    if payload.iat then
      local iat_date = os.date('%Y-%m-%d %H:%M:%S', payload.iat)
      table.insert(result, '📅 Issued: ' .. iat_date)
    end

    if payload.nbf then
      local nbf_date = os.date('%Y-%m-%d %H:%M:%S', payload.nbf)
      local is_valid = payload.nbf <= os.time()
      table.insert(result, '🚫 Not Before: ' .. nbf_date .. (is_valid and ' (Valid)' or ' (Not yet valid)'))
    end
  else
    table.insert(result, '❌ Invalid payload: ' .. tostring(payload))
  end

  table.insert(result, '')
  table.insert(result, '🔒 Signature: ' .. parts[3])
  table.insert(result, '⚠️  Note: Signature verification requires the secret key')

  utils.create_floating_window(result, {
    title = 'JWT Decoder',
    filetype = 'json',
  })
end

function M.sql_format()
  local mode = vim.fn.mode()
  local sql

  if mode == 'v' or mode == 'V' then
    sql = utils.get_visual_selection()
  else
    sql = utils.get_input 'Enter SQL query: '
  end

  if sql == '' then
    vim.notify('No SQL provided', vim.log.levels.WARN)
    return
  end

  local function format_sql(query)
    local keywords = {
      'SELECT',
      'FROM',
      'WHERE',
      'GROUP BY',
      'HAVING',
      'ORDER BY',
      'INSERT',
      'INTO',
      'VALUES',
      'UPDATE',
      'SET',
      'DELETE',
      'CREATE',
      'TABLE',
      'ALTER',
      'DROP',
      'INDEX',
      'VIEW',
      'JOIN',
      'INNER JOIN',
      'LEFT JOIN',
      'RIGHT JOIN',
      'FULL JOIN',
      'ON',
      'AND',
      'OR',
      'NOT',
      'IN',
      'EXISTS',
      'BETWEEN',
      'LIMIT',
      'OFFSET',
      'UNION',
      'INTERSECT',
      'EXCEPT',
    }

    local formatted = query

    for _, keyword in ipairs(keywords) do
      formatted = formatted:gsub('%f[%w]' .. keyword:lower() .. '%f[%W]', keyword)
      formatted = formatted:gsub('%f[%w]' .. keyword:upper() .. '%f[%W]', keyword)
    end

    formatted = formatted:gsub('SELECT%s+', 'SELECT\n    ')
    formatted = formatted:gsub('FROM%s+', '\nFROM\n    ')
    formatted = formatted:gsub('WHERE%s+', '\nWHERE\n    ')
    formatted = formatted:gsub('GROUP BY%s+', '\nGROUP BY\n    ')
    formatted = formatted:gsub('ORDER BY%s+', '\nORDER BY\n    ')
    formatted = formatted:gsub('HAVING%s+', '\nHAVING\n    ')
    formatted = formatted:gsub(',%s*', ',\n    ')
    formatted = formatted:gsub('AND%s+', '\n  AND ')
    formatted = formatted:gsub('OR%s+', '\n   OR ')

    return formatted
  end

  local result = {
    '🗃️ SQL Formatter',
    '',
    '📝 Original Query:',
    sql,
    '',
    '✨ Formatted Query:',
    '',
  }

  local formatted_lines = vim.split(format_sql(sql), '\n')
  for _, line in ipairs(formatted_lines) do
    table.insert(result, line)
  end

  utils.create_floating_window(result, {
    title = 'SQL Formatter',
    filetype = 'sql',
  })
end

function M.regex_generator()
  local patterns = {
    '🔍 Regex Pattern Generator',
    '',
    '📧 Email Patterns:',
    'Basic email: ^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,}$',
    'Strict email: ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$',
    '',
    '📱 Phone Patterns:',
    'US Phone: ^\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$',
    'International: ^\\+?[1-9]\\d{1,14}$',
    '',
    '🌐 URL Patterns:',
    'HTTP/HTTPS: ^https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)$',
    'Domain only: ^[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.[a-zA-Z]{2,}$',
    '',
    '💳 Credit Card:',
    'Visa: ^4[0-9]{12}(?:[0-9]{3})?$',
    'MasterCard: ^5[1-5][0-9]{14}$',
    'AmEx: ^3[47][0-9]{13}$',
    '',
    '🔢 Numbers:',
    'Integer: ^-?\\d+$',
    'Decimal: ^-?\\d*\\.?\\d+$',
    'Positive: ^[1-9]\\d*$',
    '',
    '📅 Date Patterns:',
    'YYYY-MM-DD: ^\\d{4}-\\d{2}-\\d{2}$',
    'MM/DD/YYYY: ^(0[1-9]|1[0-2])\\/(0[1-9]|[12]\\d|3[01])\\/(19|20)\\d{2}$',
    'DD-MM-YYYY: ^(0[1-9]|[12]\\d|3[01])-(0[1-9]|1[0-2])-(19|20)\\d{2}$',
    '',
    '🔐 Password Validation:',
    'Strong (8+ chars, upper, lower, digit): ^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d@$!%*?&]{8,}$',
    'Medium (6+ chars): ^.{6,}$',
    '',
    '💻 Programming:',
    'Variable names: ^[a-zA-Z_][a-zA-Z0-9_]*$',
    'Hex color: ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$',
    'IP Address: ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
    '',
    '📝 Text Patterns:',
    'Only letters: ^[a-zA-Z]+$',
    'Alphanumeric: ^[a-zA-Z0-9]+$',
    'No whitespace: ^\\S+$',
    'Word boundaries: \\b\\w+\\b',
    '',
    'Press t to test a pattern against text',
  }

  local buf = utils.create_floating_window(patterns, {
    title = 'Regex Generator',
  })

  vim.keymap.set('n', 't', function()
    local pattern = utils.get_input 'Enter regex pattern: '
    local test_text = utils.get_input 'Enter text to test: '

    if pattern ~= '' and test_text ~= '' then
      local ok, result = pcall(function()
        return test_text:match(pattern) ~= nil
      end)

      local test_result = {
        '🧪 Regex Test Result',
        '',
        'Pattern: ' .. pattern,
        'Text: ' .. test_text,
        'Result: ' .. (ok and (result and '✅ Match' or '❌ No match') or '💥 Invalid pattern'),
      }

      utils.create_floating_window(test_result, {
        title = 'Regex Test',
      })
    end
  end, { buffer = buf })
end

function M.cron_calculator()
  local cron = utils.get_input 'Enter cron expression (or press enter for examples): '

  if cron == '' then
    local examples = {
      '⏰ Cron Expression Calculator',
      '',
      '📋 Cron Format: * * * * *',
      '   Minute (0-59)',
      '   │ Hour (0-23)',
      '   │ │ Day of month (1-31)',
      '   │ │ │ Month (1-12)',
      '   │ │ │ │ Day of week (0-7, 0=Sunday)',
      '   │ │ │ │ │',
      '   * * * * *',
      '',
      '🕐 Common Examples:',
      '0 0 * * *     - Daily at midnight',
      '0 9 * * 1-5   - Weekdays at 9 AM',
      '*/15 * * * *  - Every 15 minutes',
      '0 0 1 * *     - First day of every month',
      '0 0 * * 0     - Every Sunday at midnight',
      '30 2 * * 6    - Saturdays at 2:30 AM',
      '0 9-17 * * 1-5 - Hourly, 9 AM to 5 PM, weekdays',
      '*/5 9-17 * * 1-5 - Every 5 min, 9 AM to 5 PM, weekdays',
      '',
      '🛠️ Special Characters:',
      '*     - Any value',
      ',     - Value list separator',
      '-     - Range of values',
      '/     - Step values',
      '',
      'Press c to calculate next run times',
    }

    local buf = utils.create_floating_window(examples, {
      title = 'Cron Calculator',
    })

    vim.keymap.set('n', 'c', function()
      M.cron_calculator()
    end, { buffer = buf })

    return
  end

  local parts = vim.split(cron, ' ')

  if #parts ~= 5 then
    vim.notify('Invalid cron format. Should be 5 space-separated fields.', vim.log.levels.ERROR)
    return
  end

  local function describe_cron(expression)
    local descriptions = {
      '⏰ Cron Expression Analysis',
      '',
      'Expression: ' .. expression,
      '',
      '📝 Field Breakdown:',
      'Minute: ' .. (parts[1] == '*' and 'Every minute' or 'Minute ' .. parts[1]),
      'Hour: ' .. (parts[2] == '*' and 'Every hour' or 'Hour ' .. parts[2]),
      'Day: ' .. (parts[3] == '*' and 'Every day' or 'Day ' .. parts[3]),
      'Month: ' .. (parts[4] == '*' and 'Every month' or 'Month ' .. parts[4]),
      'Weekday: ' .. (parts[5] == '*' and 'Every weekday' or 'Weekday ' .. parts[5]),
      '',
      '📅 Human Description:',
    }

    local desc = ''

    if parts[1] == '*' and parts[2] == '*' then
      desc = 'Every minute'
    elseif parts[1] ~= '*' and parts[2] == '*' then
      desc = 'At minute ' .. parts[1] .. ' of every hour'
    elseif parts[1] == '0' and parts[2] ~= '*' then
      desc = 'At ' .. parts[2] .. ':00'
    else
      desc = 'At ' .. parts[2] .. ':' .. (parts[1] == '*' and '**' or parts[1])
    end

    if parts[5] ~= '*' then
      local days = { [0] = 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', [7] = 'Sunday' }
      local day_num = tonumber(parts[5])
      if day_num and days[day_num] then
        desc = desc .. ' on ' .. days[day_num]
      else
        desc = desc .. ' on weekday ' .. parts[5]
      end
    end

    if parts[3] ~= '*' then
      desc = desc .. ' on day ' .. parts[3] .. ' of the month'
    end

    if parts[4] ~= '*' then
      local months = { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' }
      local month_num = tonumber(parts[4])
      if month_num and months[month_num] then
        desc = desc .. ' in ' .. months[month_num]
      else
        desc = desc .. ' in month ' .. parts[4]
      end
    end

    table.insert(descriptions, desc)

    table.insert(descriptions, '')
    table.insert(descriptions, '⏭️  Next scheduled runs would be calculated')
    table.insert(descriptions, 'by a proper cron parser. This is a basic analyzer.')

    return descriptions
  end

  local result = describe_cron(cron)

  utils.create_floating_window(result, {
    title = 'Cron Calculator',
  })
end

return M

