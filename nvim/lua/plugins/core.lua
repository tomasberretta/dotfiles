-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  -- {"rebelot/kanagawa.nvim"},

  -- Configure LazyVim to load gruvbox
  -- {
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "kanagawa",
  --  },
  -- },

  -- disable trouble
  -- { "folke/trouble.nvim", enabled = false },

  -- add any tools you want to have installed below
  -- Removed Mason section (ensure it's fully deleted)

  -- Removed LuaSnip section
}
