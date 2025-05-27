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
    "hrsh7th/cmp-emoji", -- ADDED from example.lua

    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true }, -- User's existing dependency
    "zbirenbaum/copilot-cmp", -- ADDED: copilot-cmp is now a dependency of nvim-cmp
  },
  opts = function(_, opts) -- 'opts' is the existing options table from LazyVim defaults
    -- Ensure opts.sources is a table (it should be from LazyVim)
    if type(opts.sources) ~= "table" then
      opts.sources = {}
    end

    -- Add "emoji" to the sources list
    -- We need to be careful not to duplicate if it's already there for some reason
    local emoji_source_exists = false
    for _, source in ipairs(opts.sources) do
      if source.name == "emoji" then
        emoji_source_exists = true
        break
      end
    end
    if not emoji_source_exists then
      table.insert(opts.sources, { name = "emoji" }) -- ADDED from example.lua
    end
    
    -- Ensure standard sources are present and add luasnip and copilot
    -- The original list from user's nvim-cmp.lua:
    -- local sources = {
    --   { name = "nvim_lsp" },
    --   { name = "luasnip" }, 
    --   { name = "buffer" },
    --   { name = "path" },
    --   { name = "copilot" }, 
    -- }
    -- This was replacing opts.sources. Instead, let's ensure these specific sources are present
    -- and preserve any other existing sources from LazyVim default opts.

    local desired_sources_map = {
      nvim_lsp = true,
      luasnip = true,
      buffer = true,
      path = true,
      copilot = true,
      emoji = true, -- ensure emoji is also in the desired map
    }

    local final_sources = {}
    -- Add sources from existing opts if they are in our desired_sources_map or not explicitly managed
    for _, source in ipairs(opts.sources) do
      if desired_sources_map[source.name] then
        table.insert(final_sources, source)
        desired_sources_map[source.name] = false -- mark as added
      elseif source.name ~= "emoji" then -- if it's not emoji and not in desired_sources, keep it
        table.insert(final_sources, source)
      end
    end

    -- Add any desired sources that weren't already in opts.sources
    for name, should_add in pairs(desired_sources_map) do
      if should_add then -- if true, it means it wasn't in the original opts.sources
        table.insert(final_sources, { name = name })
      end
    end
    opts.sources = final_sources
    
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
