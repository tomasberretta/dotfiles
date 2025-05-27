-- nvim/lua/plugins/ogpt.lua
return {
  {
    "huynle/ogpt.nvim",
    event = "VeryLazy", -- Or "CmdlineEnter" or specific commands if you prefer
    opts = {
      default_provider = "gemini", -- Set Gemini as the default
      providers = {
        gemini = {
          -- Ensure your GOOGLE_API_KEY environment variable is set
          api_key_cmd = "echo $GOOGLE_API_KEY", 
          -- Specify a model if desired, e.g., "gemini-pro", "gemini-1.5-flash-latest"
          -- model = "gemini-pro", 
        },
        -- ollama = { -- Example for Ollama
        --   api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
        --   api_key = os.getenv("OLLAMA_API_KEY") or "",
        --   -- model = "mistral:7b" 
        -- }
      },
      -- To enable edgy.nvim integration (if edgy.nvim is configured separately):
      -- edgy = true,
      -- For a simple chat window without edgy, you might not need extra UI config here initially.
      -- The plugin has defaults for its chat interface.
      
      -- Example: customizing keymaps for the chat window
      -- chat = {
      --   keymaps = {
      --     close = "<C-c>",
      --     yank_last = "<C-y>",
      --     -- Add other custom keymaps here
      --   },
      -- },

      -- Example: defining a custom action
      -- actions = {
      --   explain_code_gemini = {
      --     type = "popup", -- or "edit"
      --     template = "Explain the following {{{filetype}}} code:\n\n```{{{filetype}}}\n{{{input}}}\n```",
      --     strategy = "display", -- or "replace", "append"
      --     provider = "gemini", -- Ensure this action uses gemini
      --     -- model = "gemini-pro", -- Optionally override model for this specific action
      --   },
      -- },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- Optional: Add a config function if you need to run setup commands
    -- config = function(_, opts)
    --   require("ogpt").setup(opts)
    --   -- Add any custom commands or further setup here
    --   print("ogpt.nvim configured!")
    -- end,
  },
} 