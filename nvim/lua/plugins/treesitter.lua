return {
  "nvim-treesitter/nvim-treesitter",
  -- use latest
  version = false,
  opts = {
    ensure_installed = {
      -- "angular", install manually, this seems to break it
      "bash",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "html",
      "javascript",
      "json",
      "lua",
      "rust",
      "css",
      "vue",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
} 