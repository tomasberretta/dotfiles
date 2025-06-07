return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- INFO: Overriding keys for flash.nvim
  -- Default keys are:
  -- s: flash.jump()
  -- S: flash.treesitter()
  -- r: flash.remote()
  -- R: flash.treesitter_search()
  -- <c-s>: flash.toggle_mode()
  -- To disable a keymap, set it to `false`
  -- stylua: ignore
  keys = {
    { '<leader>fs', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = '[F]lash [S]earch' },
    { '<leader>fr', mode = { 'n', 'o', 'x' }, function() require('flash').remote() end, desc = '[F]lash [R]emote Search' },
    { '<leader>ft', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = '[F]lash [T]reesitter Jump' },
    { '<leader>fT', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = '[F]lash [T]reesitter Search' },
    { '<leader>fo', mode = { 'c' }, function() require('flash').toggle() end, desc = '[F]lash [O]ptions' },
  },
} 