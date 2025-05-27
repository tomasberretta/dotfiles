-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>dpm", function()
  require("dap-python").test_method()
end, { desc = "Debug Python Test Method" })

vim.keymap.set("n", "<leader>dpc", function()
  require("dap-python").test_class()
end, { desc = "Debug Python Test Class" })
