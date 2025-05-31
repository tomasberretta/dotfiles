-- nvim/lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_a = opts.sections.lualine_a or {}
    opts.sections.lualine_b = opts.sections.lualine_b or {}
    opts.sections.lualine_c = opts.sections.lualine_c or {}
    opts.sections.lualine_x = opts.sections.lualine_x or {}
    opts.sections.lualine_y = opts.sections.lualine_y or {}
    opts.sections.lualine_z = opts.sections.lualine_z or {}

    opts.sections.lualine_z = {}

    local diagnostics_exists = false
    for _, comp in ipairs(opts.sections.lualine_x) do
      if (type(comp) == "string" and comp == "diagnostics") or (type(comp) == "table" and comp[1] == "diagnostics") then
        diagnostics_exists = true
        break
      end
    end
    if not diagnostics_exists then
      table.insert(opts.sections.lualine_x, 1, "diagnostics")
    end

    opts.sections.lualine_y = opts.sections.lualine_y or {}
    local fileformat_exists = false
    for _, comp in ipairs(opts.sections.lualine_y) do
      if (type(comp) == "string" and comp == "fileformat") or (type(comp) == "table" and comp[1] == "fileformat") then
        fileformat_exists = true
        break
      end
    end
    if not fileformat_exists then
      table.insert(opts.sections.lualine_y, 1, "fileformat")
    end

    local encoding_exists = false
    for _, comp in ipairs(opts.sections.lualine_y) do
      if (type(comp) == "string" and comp == "encoding") or (type(comp) == "table" and comp[1] == "encoding") then
        encoding_exists = true
        break
      end
    end
    if not encoding_exists then
      table.insert(opts.sections.lualine_y, "fileformat_exists" and 2 or 1, "encoding")
    end

    return opts
  end,
}
