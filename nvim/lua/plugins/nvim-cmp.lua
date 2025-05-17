return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- It's good practice to list nvim-cmp's common sources/dependencies if you're overriding them.
    -- These are often part of LazyVim defaults but listing them explicitly here can improve clarity.
    "hrsh7th/cmp-nvim-lsp", -- It's good to have common sources explicit if customizing
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip", -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- LuaSnip integration for nvim-cmp

    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true }, -- User's existing dependency
    "zbirenbaum/copilot-cmp", -- ADDED: copilot-cmp is now a dependency of nvim-cmp
  },
  opts = function(_, opts) -- 'opts' is the existing options table from LazyVim defaults
    -- Ensure opts.sources is a table (it should be from LazyVim)
    if type(opts.sources) ~= "table" then
      opts.sources = {}
    end

    -- Ensure standard sources are present and add luasnip and copilot
    local sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- Added LuaSnip as a source
      { name = "buffer" },
      { name = "path" },
      { name = "copilot" }, -- Keep copilot from previous steps
    }
    
    -- Simple way to merge: replace opts.sources if you want full control over order
    -- Or, more carefully merge if LazyVim provides many other sources you want to keep.
    -- For now, let's define a standard set including luasnip.
    opts.sources = sources

    -- Setup snippet capabilities (important for LuaSnip)
    if type(opts.snippet) ~= "table" then
      opts.snippet = {}
    end
    if type(opts.snippet.expand) ~= "function" then
        opts.snippet.expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    end

    -- The tailwindcss-colorizer-cmp.nvim integration (user's existing code, preserved)
    -- This correctly wraps the existing formatter from LazyVim's opts
    local format_kinds = opts.formatting.format
    opts.formatting.format = function(entry, item)
      format_kinds(entry, item) -- Call original/default formatter first
      return require("tailwindcss-colorizer-cmp").formatter(entry, item) -- Then apply/return tailwind formatter
    end

    return opts -- Return the modified options table
  end,
}
