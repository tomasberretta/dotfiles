-- =============================================================================
-- TERMINAL INTEGRATION
-- =============================================================================
-- Integrated terminal functionality
-- Keybinding prefix: <leader>T for [T]erminal (uppercase to avoid conflicts)

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    },
    keys = {
      { '<C-\\>', desc = 'Toggle terminal' },
      { '<leader>Tf', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal [F]loat' },
      { '<leader>Th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]erminal [H]orizontal' },
      { '<leader>Tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = '[T]erminal [V]ertical' },
      { '<leader>Tt', '<cmd>ToggleTerm direction=tab<cr>', desc = '[T]erminal [T]ab' },
      -- Terminal specific mappings
      {
        '<leader>Tg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new {
            cmd = 'lazygit',
            direction = 'float',
            hidden = true,
          }
          lazygit:toggle()
        end,
        desc = '[T]erminal Lazy[G]it',
      },
    },
  },
}