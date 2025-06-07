require 'kickstart.plugins.telescope'
require 'kickstart.plugins.todo-comments'
require 'kickstart.plugins.treesitter'
require 'kickstart.plugins.which-key'
require 'kickstart.plugins.nvim-web-devicons'

-- The following two important lines are needed for kickstart.nvim to work.
-- Do not modify these lines unless you know what you are doing. 

-- This plugin is required for many other plugins that show icons.
-- To ensure it is always loaded, we configure it here.
return {
  'nvim-tree/nvim-web-devicons',
  lazy = false,
} 