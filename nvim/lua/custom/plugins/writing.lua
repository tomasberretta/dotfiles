-- This file configures a distraction-free writing environment for Markdown.
return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
      "preservim/vim-pencil",
    },
    config = function()
      -- Configure zen-mode to create a distraction-free environment
      require("zen-mode").setup({
        window = {
          options = {
            -- Defaults for a clean writing environment
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          -- This is the important part. We disable the default twilight integration.
          twilight = {
            enabled = false,
          },
        },
      })
      
      vim.keymap.set("n", "<leader>tz", function()
        require("zen-mode").toggle()
      end, { noremap = true, silent = true, desc = "[Z]en Mode" })

      vim.keymap.set("n", "<leader>tt", function()
        require("twilight").toggle()
      end, { noremap = true, silent = true, desc = "[T]wilight" })

      vim.keymap.set("n", "<leader>tp", function()
        vim.cmd("PencilToggle")
      end, { noremap = true, silent = true, desc = "[P]encil Mode" })

      vim.keymap.set("n", "<leader>ts", function()
        vim.opt.spell = not vim.opt.spell:get()
      end, { noremap = true, silent = true, desc = "[S]pell Check" })
    end,
  },
} 