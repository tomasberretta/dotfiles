return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- Specify other dependencies if neo-tree needs them for your setup
  },
  opts = {
    -- Close Neotree if it's the last window
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        visible = true, -- Ensure the filter is active
        hide_dotfiles = false, -- Show dotfiles
        hide_gitignored = true, -- You can set this to false if you want to see gitignored files
        hide_hidden = false, -- Explicitly show files that Neo-tree might consider hidden by other means
        hide_by_name = {
          -- ".git",
          -- "node_modules" 
          -- Add any other files/folders you always want to hide by name
        },
        never_show = { -- remains hidden even if visible is toggled to true
          -- ".DS_Store",
          -- "thumbs.db"
        },
      },
      follow_current_file = {
        enabled = true, -- Neo-tree will highlight the currently open file
      },
      group_empty_dirs = true, -- Groups empty directories visually
      hijack_netrw_behavior = "disabled", -- Or "disabled" or "open_default"
    },
    window = {
      mappings = {
        ["H"] = "toggle_hidden", -- Toggle hidden files with H
        ["gv"] = "previous_git_modified_item",
        ["gc"] = "show_git_status",
        -- Add other custom mappings here
      },
    },
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1, -- Padding AFTER the indent icons, not before
        -- indent_marker = "│",
        -- last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "✚", -- or "✚", ""
          modified  = "", -- or "", ""
          deleted   = "✖",-- or "✖", ""
          renamed   = "", -- or "", ""
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "•",
          staged    = "✓",
          conflict  = "",
        }
      },
    },
    -- Add other Neo-tree options here if you have them from your previous config or want to customize further
  },
  -- If you are using LazyVim, you might not need a config function if opts is handled correctly.
  -- However, if LazyVim requires it or if you need to run commands:
  config = function(_, opts)
    require("neo-tree").setup(opts)
    -- If you want to open neo-tree on startup, you can add it here, but you mentioned not wanting it to open automatically.
    -- vim.cmd([[Neotree show]])
  end,
} 