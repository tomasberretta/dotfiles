-- This file is responsible for configuring Neovim's debugging capabilities using the
-- Debug Adapter Protocol (DAP). It sets up the necessary plugins, keymaps, and
-- language-specific configurations.
return {
  -- Installs the core Debug Adapter Protocol plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Creates a beautiful UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup()

          -- Automatically open the UI when a debug session starts
          -- Note: UI will stay open after session ends so you can see test results/errors
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
        end,
      },
      -- Shows virtual text for debugging information
      "theHamsta/nvim-dap-virtual-text",
      -- Integrates Mason with DAP for easy adapter installation
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        -- Ensures the Python debugger is installed
        opts = {
          ensure_installed = { "debugpy" },
        },
      },
      -- Configures the Python debugger
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Tells nvim-dap-python where to find the Python debugger
          require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
        end,
      },
    },
    config = function()
      local dap = require("dap")

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set("n", "<leader>dt", function() dap.toggle_breakpoint() end, { desc = "[T]oggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "[C]ontinue" })
      vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "Step [O]ver" })
      vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step [I]nto" })
      vim.keymap.set("n", "<leader>du", function() dap.step_out() end, { desc = "Step O[u]t" })
      vim.keymap.set("n", "<leader>db", function() dap.run_to_cursor() end, { desc = "Run to [B]uffer Line" })
      vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run [L]ast" })
      vim.keymap.set("n", "<leader>d-t", function() require("dap.ui.widgets").hover() end, { desc = "Hover [T]ooltip" })
      vim.keymap.set("n", "<leader>d-p", function() require("dap.ui.widgets").preview() end, { desc = "[P]review Widget" })
      vim.keymap.set("n", "<leader>d-f", function() require("dap.ui.widgets").focus() end, { desc = "[F]ocus Widget" })
      vim.keymap.set("n", "<leader>d-e", function() require("dap.ui.widgets").close() end, { desc = "[E]xit Widget" })
      vim.keymap.set("n", "<leader>d-r", function() dap.repl.toggle() end, { desc = "[R]EPL Toggle" })
      vim.keymap.set("n", "<leader>dk", function() require("dap").terminate() end, { desc = "[K]ill Session" })
      vim.keymap.set("n", "<leader>dx", function() require("dapui").close() end, { desc = "Close Debug UI" })

      vim.keymap.set("n", "<leader>dpm", function() require("dap-python").test_method() end, { desc = "[P]ython Test [M]ethod" })
      vim.keymap.set("n", "<leader>dpc", function() require("dap-python").test_class() end, { desc = "[P]ython Test [C]lass" })
    end,
  },
  -- Testing framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
        },
      },
    },
  },
} 