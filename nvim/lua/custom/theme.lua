-- =============================================================================
-- UNIFIED THEME SYSTEM
-- =============================================================================
-- Simplified theme management that integrates with the centralized palette system
-- Themes: minimal (dark) and oxocarbon (light)

local M = {}

-- Apply theme overrides for consistency with terminal
local function apply_theme_overrides()
    if vim.o.background == "light" then
        -- Light mode overrides for oxocarbon to match ghostty/tmux (#f4f4f4 instead of #ffffff)
        vim.api.nvim_set_hl(0, "Normal", { bg = "#f4f4f4", fg = "#2c2c2c" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#f0f0f0", fg = "#2c2c2c" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "#f0f0f0", fg = "#2c2c2c" })
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#e8f2ff", fg = "#2c2c2c", bold = true })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#e8f2ff" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#f0f0f0" })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#f0f0f0" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "#f4f4f4" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#7a7a7a", bg = "#f4f4f4" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#4d7bd6", bg = "#f0f0f0", bold = true })
        
        -- Flash highlights for light mode with good contrast
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#f4f4f4", bg = "#4d7bd6", bold = true })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#f4f4f4", bg = "#52a065" })
        vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#f4f4f4", bg = "#9575cd", bold = true })
        vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#7a7a7a" })
        
        -- Git signs with good contrast
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#52a065", bg = "#f4f4f4" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#4d7bd6", bg = "#f4f4f4" })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e57373", bg = "#f4f4f4" })
        
        -- Which-key highlights
        vim.api.nvim_set_hl(0, "WhichKey", { fg = "#4d7bd6", bold = true })
        vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#9575cd" })
        vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#2c2c2c" })
        vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#f0f0f0" })
        
        -- Telescope highlights
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#f0f0f0", fg = "#2c2c2c" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#f0f0f0", fg = "#7a7a7a" })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#e8f2ff", fg = "#2c2c2c", bold = true })
        vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#4d7bd6", bold = true })
    else
        -- Dark mode Flash highlights
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#191B20", bg = "#F9E154", bold = true })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#191B20", bg = "#94DD8E" })
        vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#191B20", bg = "#7EB7E6", bold = true })
        vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#515669" })
    end
end

-- Function to toggle between light and dark themes
M.toggle_theme = function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.cmd("colorscheme oxocarbon")
    else
        vim.o.background = "dark"  
        vim.cmd("colorscheme minimal")
    end
    
    -- Apply overrides after changing colorscheme
    apply_theme_overrides()
    
    -- Save the theme choice for the external switcher
    local theme = vim.o.background
    local theme_file = os.getenv("HOME") .. "/.dotfiles_theme"
    local file = io.open(theme_file, "w")
    if file then
        file:write(theme .. "\n")
        file:close()
    end
end

-- Load the current theme from external theme switcher if available
local function load_current_theme()
    local theme_file = vim.fn.stdpath("config") .. "/lua/custom/current-theme.lua"
    
    -- Try to load from the auto-generated theme file first
    if vim.fn.filereadable(theme_file) == 1 then
        dofile(theme_file)
    else
        -- Fallback: check the global theme state file
        local global_theme_file = os.getenv("HOME") .. "/.dotfiles_theme"
        local file = io.open(global_theme_file, "r")
        if file then
            local theme = file:read("*line")
            file:close()
            
            if theme == "light" then
                vim.o.background = "light"
                vim.cmd("colorscheme oxocarbon")
            else
                vim.o.background = "dark"
                vim.cmd("colorscheme minimal")
            end
        else
            -- Default to dark theme
            vim.o.background = "dark"
            vim.cmd("colorscheme minimal")
        end
    end
    
    -- Apply overrides after loading theme
    apply_theme_overrides()
end

-- Load theme on startup (called from ui.lua)
M.setup = function()
    load_current_theme()
    
    -- Set up keybinding for theme toggle
    vim.keymap.set('n', '<leader>ut', M.toggle_theme, { desc = 'Toggle [U]I [T]heme (light/dark)' })
end

return M
