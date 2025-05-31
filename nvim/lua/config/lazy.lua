local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        -- colorscheme can be overriden on setup
        colorscheme = "catppuccin", -- Ensures catppuccin is the default if not set elsewhere
        -- You can override other LazyVim options here
        -- Attempt to customize the starter UI options
        ui = {
          starter = {
            -- The header is often complex ASCII art. We need to find where the text "LazyVim" might be.
            -- It could be appended to the logo or be a separate item/footer element.
            -- Let's assume it's part of the header string or an item and try to gsub it.
            -- If LazyVim generates the header as a function, this is harder to override simply.
            -- This is a guess based on common patterns.
            -- If the header is a single string:
            -- header = function(current_header_string) 
            --   return string.gsub(current_header_string, "LazyVim", "MY NEOVIM")
            -- end,
            -- More directly, if LazyVim constructs it as a table of options:
            -- For example, if the items list contains the "LazyVim" text in one of its sections.
            -- LazyVim's default starter opts function returns a table with a `header` field and `items`.
            -- The simplest way might be to provide a *new* header if the gsub is too complex.
            header = function(logo_lines_table) -- Assuming LazyVim might pass its logo lines
              local new_header_lines = {}
              local replaced = false
              for _, line in ipairs(logo_lines_table) do
                -- Try to replace a line that prominently features LazyVim or add your text
                if string.find(line, "LazyVim") then -- This is a guess
                  table.insert(new_header_lines, string.gsub(line, "LazyVim", "MY NEOVIM"))
                  replaced = true
                else
                  table.insert(new_header_lines, line)
                end
              end
              -- If LazyVim text wasn't found and replaced, maybe append your desired text
              if not replaced then
                 -- Or, if the original logo doesn't have "LazyVim" and it's added elsewhere:
                 -- We might need to provide the *full* header. 
                 -- For now, let's assume we modify the existing lines or it's not in the FIGlet part.
                 -- The text "LazyVim" might be in a subtitle or footer part of the starter config.
              end
              -- This is a simplified approach if the default header is just a table of strings.
              -- The actual structure from LazyVim docs has `header = logo` where logo is a concatenated string.
              -- So we target that string:
              local default_logo_str = table.concat(logo_lines_table, "\n")
              return string.gsub(default_logo_str, "LazyVim", "MY NEOVIM") -- General replacement
            end,
            -- It's safer to modify the existing footer if the text is there.
            -- LazyVim updates the footer with startup time, etc.
            -- Let's try to intercept the footer generation if the text is there.
            -- According to docs, the footer is set via an autocmd, so this is tricky.

            -- The most reliable way is often to redefine the items or header directly if just text change is needed
            -- and the structure is known. The LazyVim docs show the header is a literal ASCII string.
            -- Let's assume the default `opts.ui.starter` is a table we receive.
            -- We will modify its `header` field.
          },
        },
      },
    },

    -- import/override with your plugins first
    { import = "plugins" },

    -- Explicit nvim-dap-ui configuration to prevent auto-closing
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function(_, opts)
        local dap_avail, dap = pcall(require, "dap")
        if not dap_avail then
          vim.notify("nvim-dap not available for nvim-dap-ui config", vim.log.levels.ERROR)
          return
        end

        local dapui_avail, dapui = pcall(require, "dapui")
        if not dapui_avail then
          vim.notify("nvim-dap-ui not available for nvim-dap-ui config", vim.log.levels.ERROR)
          return
        end

        dapui.setup(opts) -- Apply any passed options

        -- Remove potentially conflicting default listeners from LazyVim's dap.core extra
        -- These are the names LazyVim uses in its dap.core extra for nvim-dap-ui
        if dap.listeners.after.event_initialized["dapui_config"] then
          dap.listeners.after.event_initialized["dapui_config"] = nil
          vim.notify("Removed default dapui_config listener for event_initialized", vim.log.levels.INFO)
        end
        if dap.listeners.before.event_terminated["dapui_config"] then
          dap.listeners.before.event_terminated["dapui_config"] = nil
          vim.notify("Removed default dapui_config listener for event_terminated", vim.log.levels.INFO)
        end
        if dap.listeners.before.event_exited["dapui_config"] then
          dap.listeners.before.event_exited["dapui_config"] = nil
          vim.notify("Removed default dapui_config listener for event_exited", vim.log.levels.INFO)
        end

        -- Add our custom listeners that don't close the UI
        dap.listeners.after.event_initialized["dapui_custom_ui_manager"] = function()
          vim.notify("DAP Initialized (custom ui manager), opening DAP UI", vim.log.levels.INFO)
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_custom_ui_manager"] = function()
          vim.notify("DAP Terminated (custom ui manager), DAP UI will remain open.", vim.log.levels.INFO)
          -- dapui.close({}) -- Ensure UI is not closed
        end
        dap.listeners.before.event_exited["dapui_custom_ui_manager"] = function()
          vim.notify("DAP Exited (custom ui manager), DAP UI will remain open.", vim.log.levels.INFO)
          -- dapui.close({}) -- Ensure UI is not closed
        end

        -- Setup DAP logging (as in your original zzz_dap_log_config.lua)
        local log_path = vim.fn.stdpath("cache") .. "/dap.log"
        local dap_dir = vim.fn.fnamemodify(log_path, ":h")
        if vim.fn.isdirectory(dap_dir) == 0 then
          pcall(vim.fn.mkdir, dap_dir, "p")
        end
        if dap.set_log_level then
          dap.set_log_level("TRACE")
          vim.notify("DAP log level set to TRACE. Log file: " .. log_path, vim.log.levels.INFO)
        end
      end,
    },

    -- Catppuccin theme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000, -- make sure it loads first
      opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      },
      config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin")
      end,
    },

    -- Copilot
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      dependencies = { "hrsh7th/nvim-cmp" },
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
              accept = "<C-l>",
              dismiss = "<C-h>",
            },
          },
          panel = {
            enabled = true,
          },
        })
      end,
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true`
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrw", -- Explicitly disable netrw
        "netrwPlugin", -- Ensure netrwPlugin is disabled
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Final attempt to modify the starter header by directly accessing LazyVim's config after setup.
-- This is more of a patch and might be fragile.
local function customize_starter_header_after_setup()
  pcall(function()
    local starter_config = require("mini.starter").config
    if starter_config and starter_config.header and type(starter_config.header) == "string" then
      starter_config.header = string.gsub(starter_config.header, "LazyVim", "MY NEOVIM")
      -- If the header is generated by a function in LazyVim's setup of mini.starter,
      -- this direct modification might not work or might be overwritten.
      -- We need to ensure this runs *after* LazyVim has configured mini.starter but *before* it's shown.
    elseif starter_config and starter_config.header and type(starter_config.header) == "table" then
      for i, line in ipairs(starter_config.header) do
        starter_config.header[i] = string.gsub(line, "LazyVim", "MY NEOVIM")
      end
    end
    -- If mini.starter is already open, refresh it
    if package.loaded["mini.starter"] and require("mini.starter").refresh then
      require("mini.starter").refresh()
    end
  end)
end

-- Try to run this customization when the UI is ready or starter is about to open.
-- This is tricky because we need to time it correctly.
-- A User event from LazyVim or mini.starter would be ideal.
-- `VimEnter` might be too early if mini.starter is set up lazily by LazyVim's internals.
-- `MiniStarterOpened` is an event from mini.starter itself.

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterPreOpen", -- Or "MiniStarterOpened"
  callback = customize_starter_header_after_setup,
}) 

-- A more direct approach if LazyVim has a global config table for starter
-- This is highly dependent on LazyVim internal structure
pcall(function()
  if require("lazyvim.config").ui and require("lazyvim.config").ui.starter then
    local starter_opts = require("lazyvim.config").ui.starter
    if starter_opts.header and type(starter_opts.header) == "string" then
      starter_opts.header = string.gsub(starter_opts.header, "LazyVim", "MY NEOVIM")
    elseif starter_opts.header and type(starter_opts.header) == "table" then
       for i, line in ipairs(starter_opts.header) do
        starter_opts.header[i] = string.gsub(line, "LazyVim", "MY NEOVIM")
      end
    end
  end
end)