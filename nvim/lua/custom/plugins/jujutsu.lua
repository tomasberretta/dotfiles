-- =============================================================================
-- JUJUTSU (JJ) INTEGRATION - <leader>j
-- =============================================================================
-- Uses Snacks.terminal to run lazyjj

return {
  {
    'avm99963/vim-jjdescription',
    ft = { 'jj', 'jjdescription' },
  },

  {
    dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins',
    name = 'jj-integration',
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      local function toggle_lazyjj()
        Snacks.terminal.toggle('lazyjj', {
          cwd = vim.fn.systemlist('jj root')[1] or vim.fn.getcwd(),
          win = {
            border = 'rounded',
            position = 'float',
            keys = {
              q = 'close',
            },
          },
        })
      end

      local function jj_cmd(cmd, opts)
        opts = opts or {}
        local result = vim.fn.system('jj ' .. cmd)
        if vim.v.shell_error ~= 0 then
          if not opts.silent then
            vim.notify('jj error: ' .. result, vim.log.levels.ERROR)
          end
          return nil
        end
        return result
      end

      local function is_jj_repo()
        return jj_cmd('root', { silent = true }) ~= nil
      end

      vim.api.nvim_create_user_command('LazyJJ', function()
        if vim.fn.executable 'lazyjj' == 0 then
          vim.notify('lazyjj not found. Install with: cargo install lazyjj', vim.log.levels.ERROR)
          return
        end
        toggle_lazyjj()
      end, { desc = 'Open LazyJJ' })

      vim.api.nvim_create_user_command('JJStatus', function()
        if not is_jj_repo() then
          vim.notify('Not a jj repository', vim.log.levels.WARN)
          return
        end
        local status = jj_cmd 'status'
        if status then
          vim.notify(status, vim.log.levels.INFO)
        end
      end, { desc = 'Show jj status' })

      vim.api.nvim_create_user_command('JJDiff', function()
        if not is_jj_repo() then
          vim.notify('Not a jj repository', vim.log.levels.WARN)
          return
        end
        local diff = jj_cmd 'diff'
        if diff then
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(diff, '\n'))
          vim.bo[buf].filetype = 'diff'
          vim.cmd 'vsplit'
          vim.api.nvim_win_set_buf(0, buf)
        end
      end, { desc = 'Show jj diff' })

      vim.api.nvim_create_user_command('JJDescribe', function(args)
        if not is_jj_repo() then
          vim.notify('Not a jj repository', vim.log.levels.WARN)
          return
        end
        local msg = args.args
        if msg == '' then
          msg = vim.fn.input 'Description: '
        end
        if msg ~= '' then
          local result = jj_cmd('describe -m "' .. msg:gsub('"', '\\"') .. '"')
          if result then
            vim.notify('Updated description', vim.log.levels.INFO)
          end
        end
      end, { nargs = '?', desc = 'Describe current change' })

      vim.api.nvim_create_user_command('JJNew', function(args)
        if not is_jj_repo() then
          vim.notify('Not a jj repository', vim.log.levels.WARN)
          return
        end
        local cmd = 'new'
        if args.args ~= '' then
          cmd = cmd .. ' -m "' .. args.args:gsub('"', '\\"') .. '"'
        end
        local result = jj_cmd(cmd)
        if result then
          vim.notify('Created new change', vim.log.levels.INFO)
        end
      end, { nargs = '?', desc = 'Create new change' })

      vim.api.nvim_create_user_command('JJSquash', function()
        if not is_jj_repo() then
          vim.notify('Not a jj repository', vim.log.levels.WARN)
          return
        end
        local result = jj_cmd 'squash'
        if result then
          vim.notify('Squashed into parent', vim.log.levels.INFO)
        end
      end, { desc = 'Squash into parent' })

      vim.keymap.set('n', '<leader>jj', '<cmd>LazyJJ<cr>', { desc = '[J]ujutsu: Lazy[J]J' })
      vim.keymap.set('n', '<leader>js', '<cmd>JJStatus<cr>', { desc = '[J]ujutsu: [S]tatus' })
      vim.keymap.set('n', '<leader>jd', '<cmd>JJDiff<cr>', { desc = '[J]ujutsu: [D]iff' })
      vim.keymap.set('n', '<leader>jn', '<cmd>JJNew<cr>', { desc = '[J]ujutsu: [N]ew change' })
      vim.keymap.set('n', '<leader>jD', '<cmd>JJDescribe<cr>', { desc = '[J]ujutsu: [D]escribe' })
      vim.keymap.set('n', '<leader>jq', '<cmd>JJSquash<cr>', { desc = '[J]ujutsu: s[Q]uash' })
    end,
  },
}
