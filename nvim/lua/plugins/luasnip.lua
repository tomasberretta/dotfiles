return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    -- You can add custom snippets paths here if needed
    -- require("luasnip.loaders.from_lua").load({paths = "./my-snippets"})
  end,
} 