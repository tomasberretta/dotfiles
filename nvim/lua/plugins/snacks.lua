return {
  "folke/snacks.nvim", -- The plugin name for snacks.nvim is often just "snacks.nvim" or from folke
  event = "VimEnter", -- Or VeryLazy, ensure it's configured before dashboard shows
  opts = {
    dashboard = {
      -- enabled = true, -- Explicitly enable if needed, though LazyVim extras usually handle this
      preset = {
        header = table.concat({
          "             .--.           .---.        .-.                  ",
          "         .---|--|   .-.     | B |  .---. |~|    .--.          ",
          "      .--|===|Ch|---|_|--.__| o |--|:::| |~|-==-|==|---.      ",
          "      |%%|NT2|oc|===| |~~|%%| o |--|   |_|~|CATS|  |___|      ",
          "      |  |   |ah|===| |==|  | k |  |:::|=| |    |GB|---|      ",
          "      |  |   |ol|   |_|__|  | s |__|   | | |    |  |___|      ",
          "      |~~|===|--|===|~|~~|%%|~~~|--|:::|=|~|----|==|---|      ",
          "      ^--^---'--^---^-^--^--^---'--^---^-^-^-==-^--^---^      ",
          "", -- Empty line for spacing
          "      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗      ",
          "      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║      ",
          "      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║      ",
          "      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║      ",
          "      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║      ",
          "      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝      ",
        }, "\n"),
        -- Items will use LazyVim's defaults for snacks.nvim dashboard preset
      },
    },
    -- You might need to disable mini.starter if snacks.nvim is now fully handling the dashboard
    -- and you want to avoid any potential for mini.starter to also try and draw something.
    -- However, LazyVim extras often manage this, e.g., snacks.nvim might tell mini.starter not to run.
    -- For now, let's not add this, but keep it in mind if two dashboards appear.
    -- mini_starter = {
    --   enabled = false,
    -- },
  },
} 
