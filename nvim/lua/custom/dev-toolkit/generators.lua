local utils = require('custom.dev-toolkit').utils
local M = {}

function M.uuid()
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

  local function random_hex()
    return string.format('%x', math.random(0, 15))
  end

  math.randomseed(os.time() + os.clock() * 1000000)

  local uuid = template:gsub('[xy]', function(c)
    local v = (c == 'x') and math.random(0, 15) or math.random(8, 11)
    return string.format('%x', v)
  end)

  local variations = {
    '🆔 UUID Generator',
    '',
    'UUID v4 (Random): ' .. uuid,
    'UUID v4 (Alt): ' .. template:gsub('[xy]', function(c)
      local v = (c == 'x') and math.random(0, 15) or math.random(8, 11)
      return string.format('%x', v)
    end),
    '',
    '📋 Format Variations:',
    'Uppercase: ' .. string.upper(uuid),
    'No dashes: ' .. uuid:gsub('-', ''),
    'Braces: {' .. uuid .. '}',
    'URN: urn:uuid:' .. uuid,
    '',
    'Press y to yank UUID to clipboard',
  }

  local buf = utils.create_floating_window(variations, {
    title = 'UUID Generator',
  })

  vim.keymap.set('n', 'y', function()
    vim.fn.setreg('+', uuid)
    vim.notify('UUID copied to clipboard: ' .. uuid, vim.log.levels.INFO)
  end, { buffer = buf })
end

function M.qr_code()
  local text = utils.get_input 'Enter text for QR code: '

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local qr_ascii = {
    '📱 QR Code Generator',
    '',
    'Text: ' .. text,
    '',
    '⬛⬜⬛⬛⬜⬛⬛⬜⬛⬛⬜⬛',
    '⬜⬛⬜⬜⬛⬜⬜⬛⬜⬜⬛⬜',
    '⬛⬜⬛⬛⬜⬛⬛⬜⬛⬛⬜⬛',
    '⬜⬛⬜⬜⬛⬜⬜⬛⬜⬜⬛⬜',
    '⬛⬜⬛⬛⬜⬛⬛⬜⬛⬛⬜⬛',
    '⬜⬛⬜⬜⬛⬜⬜⬛⬜⬜⬛⬜',
    '⬛⬜⬛⬛⬜⬛⬛⬜⬛⬛⬜⬛',
    '',
    'Note: This is a mock QR code visualization.',
    'For real QR codes, use online generators or',
    'install qrencode: brew install qrencode',
    '',
    'Command to generate real QR code:',
    'qrencode -t UTF8 "' .. text .. '"',
  }

  utils.create_floating_window(qr_ascii, {
    title = 'QR Code Generator',
  })
end

function M.hash()
  local mode = vim.fn.mode()
  local text

  if mode == 'v' or mode == 'V' then
    text = utils.get_visual_selection()
  else
    text = utils.get_input 'Enter text to hash: '
  end

  if text == '' then
    vim.notify('No text provided', vim.log.levels.WARN)
    return
  end

  local function simple_hash(str, algorithm)
    local hash = 0
    for i = 1, #str do
      hash = (hash * 31 + str:byte(i)) % 2147483647
    end
    return string.format('%08x', hash)
  end

  local hashes = {
    '🔒 Hash Generator',
    '',
    'Input: ' .. text,
    '',
    '📋 Hash Results:',
    'Simple Hash: ' .. simple_hash(text),
    '',
    '⚠️  Note: These are simplified hashes for demo.',
    'For production use, install proper tools:',
    '',
    'System commands:',
    'MD5: echo -n "' .. text .. '" | md5sum',
    'SHA1: echo -n "' .. text .. '" | sha1sum',
    'SHA256: echo -n "' .. text .. '" | sha256sum',
    'SHA512: echo -n "' .. text .. '" | sha512sum',
    '',
    'macOS alternatives:',
    'MD5: echo -n "' .. text .. '" | md5',
    'SHA256: echo -n "' .. text .. '" | shasum -a 256',
  }

  utils.create_floating_window(hashes, {
    title = 'Hash Generator',
  })
end

function M.lorem()
  local count = tonumber(utils.get_input('Number of paragraphs (1-10): ', '3'))

  if not count or count < 1 or count > 10 then
    count = 3
  end

  local lorem_words = {
    'lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'sed',
    'do',
    'eiusmod',
    'tempor',
    'incididunt',
    'ut',
    'labore',
    'et',
    'dolore',
    'magna',
    'aliqua',
    'enim',
    'ad',
    'minim',
    'veniam',
    'quis',
    'nostrud',
    'exercitation',
    'ullamco',
    'laboris',
    'nisi',
    'aliquip',
    'ex',
    'ea',
    'commodo',
    'consequat',
    'duis',
    'aute',
    'irure',
    'in',
    'reprehenderit',
    'voluptate',
    'velit',
    'esse',
    'cillum',
    'fugiat',
    'nulla',
    'pariatur',
    'excepteur',
    'sint',
    'occaecat',
    'cupidatat',
    'non',
    'proident',
    'sunt',
    'culpa',
    'qui',
    'officia',
    'deserunt',
    'mollit',
    'anim',
    'id',
    'est',
    'laborum',
  }

  math.randomseed(os.time())

  local result = { '📝 Lorem Ipsum Generator', '' }

  for p = 1, count do
    local paragraph = {}
    local sentences = math.random(3, 7)

    for s = 1, sentences do
      local sentence = {}
      local words = math.random(5, 15)

      for w = 1, words do
        local word = lorem_words[math.random(#lorem_words)]
        if w == 1 then
          word = word:sub(1, 1):upper() .. word:sub(2)
        end
        table.insert(sentence, word)
      end

      table.insert(paragraph, table.concat(sentence, ' ') .. '.')
    end

    table.insert(result, table.concat(paragraph, ' '))
    table.insert(result, '')
  end

  utils.create_floating_window(result, {
    title = 'Lorem Ipsum Generator',
  })
end

function M.timestamp()
  local now = os.time()
  local utc_now = os.date('!*t', now)
  local local_now = os.date('*t', now)

  local timestamps = {
    '⏰ Timestamp Generator',
    '',
    '📅 Current Timestamps:',
    '',
    'Unix Timestamp: ' .. tostring(now),
    'Unix (milliseconds): ' .. tostring(now * 1000),
    '',
    '🌍 UTC Formats:',
    'ISO 8601: ' .. os.date('!%Y-%m-%dT%H:%M:%SZ', now),
    'RFC 2822: ' .. os.date('!%a, %d %b %Y %H:%M:%S GMT', now),
    'Human readable: ' .. os.date('!%B %d, %Y %H:%M:%S UTC', now),
    '',
    '🏠 Local Time:',
    'ISO 8601: ' .. os.date('%Y-%m-%dT%H:%M:%S', now),
    'Human readable: ' .. os.date('%B %d, %Y %H:%M:%S', now),
    'Compact: ' .. os.date('%Y%m%d_%H%M%S', now),
    '',
    '⚙️  Custom Formats:',
    'Date only: ' .. os.date('%Y-%m-%d', now),
    'Time only: ' .. os.date('%H:%M:%S', now),
    'Filename safe: ' .. os.date('%Y-%m-%d_%H-%M-%S', now),
    '',
    'Enter custom timestamp to convert:',
  }

  local buf = utils.create_floating_window(timestamps, {
    title = 'Timestamp Generator',
  })

  vim.keymap.set('n', 'c', function()
    local custom = utils.get_input 'Enter Unix timestamp: '
    local custom_num = tonumber(custom)

    if custom_num then
      local custom_result = {
        '⏰ Custom Timestamp Conversion',
        '',
        'Unix Timestamp: ' .. custom,
        'UTC: ' .. os.date('!%Y-%m-%d %H:%M:%S', custom_num),
        'Local: ' .. os.date('%Y-%m-%d %H:%M:%S', custom_num),
        'Human: ' .. os.date('%B %d, %Y at %H:%M:%S', custom_num),
      }

      utils.create_floating_window(custom_result, {
        title = 'Timestamp Conversion',
      })
    else
      vim.notify('Invalid timestamp', vim.log.levels.ERROR)
    end
  end, { buffer = buf })
end

function M.color_palette()
  local colors = {
    '🎨 Color Palette Generator',
    '',
    '🔴 Red Palette:',
    '#FF0000 ████ Red',
    '#FF3333 ████ Light Red',
    '#CC0000 ████ Dark Red',
    '#FF6666 ████ Pink Red',
    '#990000 ████ Maroon',
    '',
    '🟢 Green Palette:',
    '#00FF00 ████ Lime',
    '#008000 ████ Green',
    '#00CC00 ████ Light Green',
    '#006600 ████ Dark Green',
    '#33FF33 ████ Bright Green',
    '',
    '🔵 Blue Palette:',
    '#0000FF ████ Blue',
    '#3333FF ████ Light Blue',
    '#0000CC ████ Medium Blue',
    '#000066 ████ Dark Blue',
    '#6666FF ████ Periwinkle',
    '',
    '🟡 Yellow Palette:',
    '#FFFF00 ████ Yellow',
    '#FFD700 ████ Gold',
    '#FFFF33 ████ Light Yellow',
    '#CCCC00 ████ Dark Yellow',
    '#FFFFCC ████ Cream',
    '',
    '🟣 Purple Palette:',
    '#800080 ████ Purple',
    '#9933FF ████ Violet',
    '#663399 ████ Dark Purple',
    '#CC66FF ████ Light Purple',
    '#4B0082 ████ Indigo',
    '',
    '⚫ Grayscale:',
    '#000000 ████ Black',
    '#333333 ████ Dark Gray',
    '#666666 ████ Gray',
    '#999999 ████ Light Gray',
    '#CCCCCC ████ Very Light Gray',
    '#FFFFFF ████ White',
  }

  utils.create_floating_window(colors, {
    title = 'Color Palette',
  })
end

return M

