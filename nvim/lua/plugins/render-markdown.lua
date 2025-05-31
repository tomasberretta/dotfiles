return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Essential dependency
  -- You can add 'echasnovski/mini.icons' or 'nvim-tree/nvim-web-devicons' here if you want icons
  -- and 'pylatexenc' if you need LaTeX support (requires system install too)
  config = function()
    require("render-markdown").setup({
      -- You can customize options here if needed
      -- For example, to enable it only in normal mode:
      -- render_modes = { "n" },
    })
  end,
  keys = {
    {
      "<leader>mp",
      function() require("render-markdown").toggle() end,
      noremap = true,
      silent = true,
      desc = "Toggle Markdown Render",
    },
  },
  ft = { "markdown" }, -- Or { "markdown", "vimwiki" } if you use vimwiki
} 