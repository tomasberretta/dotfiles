-- nvim/lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts) -- Ensure we receive existing opts from LazyVim
    -- Ensure opts.sections and opts.sections.lualine_x exist
    if not opts.sections then opts.sections = {} end
    if not opts.sections.lualine_x then opts.sections.lualine_x = {} end

    table.insert(opts.sections.lualine_x, {
      function()
        return "😄"
      end,
      -- You can add conditions or color here if needed
      -- cond = nil,
      -- color = { fg = "green" },
    })
    return opts -- Return the modified opts
  end,
} 