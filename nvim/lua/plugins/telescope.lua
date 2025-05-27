return {
  "telescope.nvim",
  cmd = "Telescope", -- Eager load on Telescope command
  dependencies = {
    "nvim-lua/plenary.nvim", -- Common Telescope dependency
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  keys = {
    -- You can keep other general Telescope keymaps here if you have them:
    -- { "<leader>ff", function() require("telescope.builtin").find_files({ find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'} }) end, desc = "Find Files (All)" },
    -- { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.5
        }
      },
      sorting_strategy = "ascending",
      winblend = 0,
    },
    pickers = {
      find_files = {
        hidden = true, -- Show hidden files by default when finding files
        layout_strategy = "horizontal",         -- Explicitly set for this picker
        layout_config = {                       -- Explicitly set for this picker
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.5             -- Adjust as needed, CHANGED to float
          }
        },
      },
      live_grep = {                           -- ADDED for side-by-side grep
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.6             -- Adjust preview width as needed, CHANGED to float
          }
        },
      },
      grep_string = {                         -- ADDED for side-by-side grep
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.6             -- Adjust preview width as needed, CHANGED to float
          }
        },
      },
      git_files = { -- specific options for git_files, if needed
        theme = "dropdown",
        show_untracked = true, -- Optionally show untracked files too
      },
      projects = { -- ADDED from example.lua
        hidden = true, 
        theme = "dropdown", 
        path_display = function(opts, path) return path end,
      },
    },
    extensions = {
      fzf = {
        -- Options for fzf native
      },
    },
  },
  config = function(_, opts)
    vim.print("[Config] Configuring Telescope...")
    require("telescope").setup(opts) -- This should process opts.extensions
    
    vim.print("[Config] Loading fzf extension...")
    require("telescope").load_extension("fzf")
  end,
} 