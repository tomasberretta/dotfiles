-- nvim/lua/plugins/zzz_dap_log_config.lua
return {
  {
    "mfussenegger/nvim-dap",
    lazy = false, -- Load it eagerly for log setup
    priority = 1001, -- Higher priority to ensure its config runs after the extra's config
    config = function()
      -- Ensure log directory exists
      local log_path = vim.fn.stdpath("cache") .. "/dap.log" -- Using cache directory
      local dap_dir = vim.fn.fnamemodify(log_path, ":h")
      if vim.fn.isdirectory(dap_dir) == 0 then
        vim.fn.mkdir(dap_dir, "p")
      end
      vim.print("Setting DAP log level to TRACE. Log file: " .. log_path) -- For visual confirmation
      require("dap").set_log_level("TRACE")

      local dapui_avail, dapui = pcall(require, "dapui")
      if not dapui_avail then
        vim.print("nvim-dap-ui not available")
        return
      end

      local dap_avail, dap = pcall(require, "dap")
      if not dap_avail then
        vim.print("nvim-dap not available")
        return
      end

      dap.listeners.after.event_initialized["dapui_config_trace"] = function()
        vim.print("DAP Initialized, opening DAP UI")
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config_trace"] = function()
        vim.print("DAP Terminated, closing DAP UI")
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config_trace"] = function()
        vim.print("DAP Exited, closing DAP UI")
        dapui.close({})
      end
    end,
  },
} 