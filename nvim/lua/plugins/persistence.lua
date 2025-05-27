return {
  "folke/persistence.nvim",
  opts = {
    enabled = true,
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },
}