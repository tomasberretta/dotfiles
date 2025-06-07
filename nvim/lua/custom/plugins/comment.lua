-- This file adds a custom keybinding for commenting.
-- The underlying plugin, mini.comment, is already included in kickstart.nvim.
return {
  'mini.comment',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  keys = {
    {
      '<leader>tc',
      'gcc',
      mode = 'n',
      remap = true,
      desc = '[C]omment line',
    },
    {
      '<leader>tc',
      'gc',
      mode = 'v',
      remap = true,
      desc = '[C]omment selection',
    },
  },
  opts = {
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring.internal').calculate_commentstring()
      end,
    },
  },
} 