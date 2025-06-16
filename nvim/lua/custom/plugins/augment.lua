return {
  'augmentcode/augment.vim',
  config = function()
    -- INFO: You can add your project folders here to improve the context for the AI.
    vim.g.augment_workspace_folders = { '~/Projects' }
  end,
  keys = {
    { '<leader>ac', ':Augment chat<CR>', desc = '[A]ugment [C]hat' },
    { '<leader>an', ':Augment chat-new<CR>', desc = '[A]ugment [N]ew Chat' },
    { '<leader>at', ':Augment chat-toggle<CR>', desc = '[A]ugment [T]oggle Chat' },
  },
} 