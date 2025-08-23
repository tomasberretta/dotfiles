return {
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'echasnovski/mini.comment',
    event = "VeryLazy",
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
