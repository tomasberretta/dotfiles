return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.g.lint_enabled = true

      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if not vim.g.lint_enabled then
            return
          end
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })

      vim.keymap.set('n', '<leader>xl', function()
        vim.g.lint_enabled = not vim.g.lint_enabled
        if vim.g.lint_enabled then
          vim.notify 'Linting ON'
          lint.try_lint()
        else
          vim.notify 'Linting OFF'
          local ft = vim.bo.filetype
          local linters_for_ft = lint.linters_by_ft[ft]
          if linters_for_ft then
            for _, linter_name in ipairs(linters_for_ft) do
              vim.diagnostic.reset(require('lint').get_namespace(linter_name))
            end
          end
        end
      end, { desc = 'Toggle [L]int' })
    end,
  },
}
