-- nvim/lua/plugins/zzz_dap_log_config.lua
return {
  {
    -- "mfussenegger/nvim-dap",
    -- lazy = false, -- Load it eagerly for log setup
    -- priority = 1001, -- Higher priority to ensure its config runs after the extra's config
    -- config = function()
    --   -- Ensure log directory exists
    --   local log_path = vim.fn.stdpath("cache") .. "/dap.log" -- Using cache directory
    --   local dap_dir = vim.fn.fnamemodify(log_path, ":h")
    --   if vim.fn.isdirectory(dap_dir) == 0 then
    --     vim.fn.mkdir(dap_dir, "p")
    --   end
    -- end,
  },
}