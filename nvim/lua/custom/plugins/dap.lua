return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio", -- a dependency for neotest + dap
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

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

      vim.keymap.set("n", "<leader>dpm", function() require("dap-python").test_method() end, { desc = "[P]ython Test [M]ethod" })
      vim.keymap.set("n", "<leader>dpc", function() require("dap-python").test_class() end, { desc = "[P]ython Test [C]lass" })
    end,
  },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, opts = {} },
  { "theHamsta/nvim-dap-virtual-text", opts = {} },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup()
    end,
  },
}
