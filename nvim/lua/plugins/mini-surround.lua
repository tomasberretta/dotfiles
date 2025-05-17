return {
  "echasnovski/mini.surround",
  event = "VeryLazy", -- Load it lazily
  config = function()
    require("mini.surround").setup({
      -- No specific options needed for default setup, but you can add them here.
      -- For example:
      -- mappings = {
      --   add = "sa", -- Add surrounding
      --   delete = "sd", -- Delete surrounding
      --   find = "sf", -- Find surrounding (to replace)
      --   find_left = "sF", -- Find surrounding (to replace, from left)
      --   highlight = "sh", -- Highlight surrounding
      --   replace = "sr", -- Replace surrounding
      --   update_n_lines = "sn", -- Update `n_lines` surrounding
      -- },
    })
  end,
} 