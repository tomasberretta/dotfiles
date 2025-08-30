-- =============================================================================
-- CUSTOM PLUGINS LOADER
-- =============================================================================
-- This file loads all modular plugin configurations
-- Plugins are organized by functionality for better maintainability

return {
  -- Import all plugin modules
  { import = 'custom.plugins.core' },        -- Core utilities and dependencies
  { import = 'custom.plugins.ui' },          -- UI enhancements and themes
  { import = 'custom.plugins.treesitter' },  -- Syntax highlighting
  { import = 'custom.plugins.lsp' },         -- Language Server Protocol
  { import = 'custom.plugins.completion' },  -- Autocompletion
  { import = 'custom.plugins.telescope' },   -- Fuzzy finding
  { import = 'custom.plugins.navigation' },  -- File navigation and bookmarks
  { import = 'custom.plugins.editing' },     -- Code editing and refactoring
  { import = 'custom.plugins.git' },         -- Git integration
  { import = 'custom.plugins.debugging' },   -- Debug Adapter Protocol
  { import = 'custom.plugins.python' },      -- Python-specific tools
  { import = 'custom.plugins.terminal' },    -- Terminal integration
  { import = 'custom.plugins.writing' },     -- Writing and markdown support
}
