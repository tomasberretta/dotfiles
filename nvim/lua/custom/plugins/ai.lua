return {
  {
    'augmentcode/augment.vim',
    event = 'VeryLazy',
    init = function()
      vim.g.augment_workspace_folders = { vim.fn.getcwd() }
    end,
    keys = {
      { '<leader>ae', '<cmd>Augment enable<cr>', desc = '[A]I: [E]nable' },
      { '<leader>ad', '<cmd>Augment disable<cr>', desc = '[A]I: [D]isable' },
      { '<leader>ac', '<cmd>Augment chat<cr>', desc = '[A]I: [C]hat' },
    },
  },
}
