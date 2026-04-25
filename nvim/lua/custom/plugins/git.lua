-- =============================================================================
-- GIT INTEGRATION - <leader>g
-- =============================================================================
-- LazyGit (<leader>gg/gf/gl) and gitbrowse (<leader>go) live in plugins/snacks.lua

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gs.nav_hunk 'next'
          end
        end, { desc = 'Next hunk' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gs.nav_hunk 'prev'
          end
        end, { desc = 'Prev hunk' })

        map('n', '<leader>gs', gs.stage_hunk, { desc = '[G]it [S]tage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = '[G]it [R]eset hunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [S]tage hunk' })
        map('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [R]eset hunk' })

        map('n', '<leader>gS', gs.stage_buffer, { desc = '[G]it [S]tage buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[G]it [U]ndo stage' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = '[G]it [R]eset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = '[G]it [P]review hunk' })

        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = '[G]it [B]lame line' })
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[G]it [B]lame toggle' })

        map('n', '<leader>gd', gs.diffthis, { desc = '[G]it [D]iff' })
        map('n', '<leader>gD', function()
          gs.diffthis '@'
        end, { desc = '[G]it [D]iff HEAD' })

        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end,
    },
  },

  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = '[G]it [V]iew diff' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it [H]istory file' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it [H]istory all' },
      { '<leader>gx', '<cmd>DiffviewClose<cr>', desc = '[G]it e[X]it diffview' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = 'diff2_horizontal' },
        merge_tool = { layout = 'diff3_mixed' },
      },
    },
  },
}
