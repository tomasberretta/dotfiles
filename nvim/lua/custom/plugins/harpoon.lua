-- A plugin for managing a list of frequently accessed files (marks) for quick navigation.
-- Disabled to prefer Harpoon2 from LazyVim extras.
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- call setup, as we are not using opts
    require("harpoon"):setup()
  end,
  keys = {
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "[A]dd File" },
    { "<leader>he", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "[E]xplorer" },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4" },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to File 5" },
  },
}
