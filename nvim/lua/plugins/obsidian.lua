return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- Let's try a slightly later event for loading
  event = { "BufReadPost *.md", "BufNewFile *.md" }, 
  -- ft = "markdown", -- Using event instead of ft for this test
  -- If you only want to load obsidian.nvim for markdown files in your vault, you can use:
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~/Obsidian/tomas" .. "/**.md",
  --   "BufNewFile " .. vim.fn.expand "~/Obsidian/tomas" .. "/**.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Optional, for completion support.
    "hrsh7th/nvim-cmp", 
    -- Optional, for search functionality (requires search command like 'rg').
    "nvim-telescope/telescope.nvim", 
  },
  opts = function()
    -- Defer requiring cmp until opts is actually called, which lazy.nvim might handle better
    local cmp_ok, cmp = pcall(require, "cmp")
    
    local obsidian_opts = {
    workspaces = {
      {
          name = "tomas-vault", -- You can name your vault as you like
          path = "/Users/tomiberretta/Library/Mobile Documents/iCloud~md~obsidian/Documents/tomas - mobile",
        },
        -- You can add more vaults here if needed
        -- {
        --   name = "work",
        --   path = "~/work-vault",
        -- },
      },

      -- Optional: Defines a nicer path for new notes created from non-markdown files.
      new_notes_location = "notes", -- relative to vault root, so new notes will be in "~/Obsidian/tomas/notes"

      -- Optional: Configure keybindings. obsidian.nvim will merge these with default tables.
      --mappings = {},

      -- Optional: Where to put new notes created from undefined links. Valid options are
      --   * "current_dir" - put new notes in the same directory as the current buffer.
      --   * "notes_subdir" - put new notes in the default notes subdirectory.
      new_note_location = "notes_subdir",

      -- Control how wiki links are formatted. If "use_path_only", then the path is used directly.
      -- If "prepend_note_id" (default), then the note ID is prepended to the path.
      -- wiki_link_func = "prepend_note_id",

      -- Optional: Configure how note IDs are generated. This is your existing function.
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = tostring(os.time()) .. "-" .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,

      -- Optional: Disable frontmatter, this is your existing setting.
    disable_frontmatter = true,

      -- Optional: Configure daily notes.
      daily_notes = {
        folder = "daily", -- Subfolder for daily notes, relative to the vault root, e.g., "~/Obsidian/tomas/daily"
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = nil, -- Path to a template file for daily notes.
      },

      -- Optional: Configure completion.
      completion = {
        -- Only enable nvim_cmp integration if cmp was successfully required
        nvim_cmp = cmp_ok, 
        min_chars = 2,   -- Minimum characters to trigger completion.
      },

      -- Optional: Configure commands for finding notes (requires telescope.nvim).
      -- find_notes_command = "Telescope find_files cwd=%s",
      -- find_backlinks_command = "Telescope grep_string Pword=%s cwd=%s",

      -- Optional: Template for new notes. This is a file path.
      -- new_note_template = nil,

      -- Optional: Function to determine the path to a new note.
      -- new_note_path_func = function(note_path_parts) end,

      -- Optional: Function to determine the path to a new daily note.
      -- new_daily_note_path_func = function(date_format_string) end,

      -- Optional: Sort order for backlinks.
      -- sort_backlinks = "modified",

      -- Optional: Specific configuration for a "zettlekasten" setup.
      -- zettelkasten = { ... },

      -- Optional: YAML key name to use for titles. Defaults to "title".
      -- title_yaml_key = "title",

      -- Optional: YAML key name to use for aliases. Defaults to "aliases".
      -- aliases_yaml_key = "aliases",

      -- Optional: YAML key name to use for tags. Defaults to "tags".
      -- tags_yaml_key = "tags",

      -- Other options...
    }
    return obsidian_opts
  end,
}
