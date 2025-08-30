-- =============================================================================
-- GIT INTEGRATION
-- =============================================================================
-- Complete git workflow integration for Neovim
-- Keybinding prefix: <leader>g for [G]it operations

return {
  -- Gitsigns: Git integration for buffers
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

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gs.nav_hunk 'next'
          end
        end, { desc = 'Next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gs.nav_hunk 'prev'
          end
        end, { desc = 'Previous git [c]hange' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = '[G]it [S]tage hunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = '[G]it [R]eset hunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [S]tage hunk' })
        map('v', '<leader>gr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [R]eset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = '[G]it [S]tage buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[G]it [U]ndo stage hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = '[G]it [R]eset buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = '[G]it [P]review hunk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = '[G]it [B]lame line' })
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[G]it toggle [B]lame' })
        map('n', '<leader>gd', gs.diffthis, { desc = '[G]it [D]iff against index' })
        map('n', '<leader>gD', function()
          gs.diffthis '@'
        end, { desc = '[G]it [D]iff against last commit' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
      end,
    },
  },

  -- Fugitive: Git commands integration
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = '[G]it status' },
      { '<leader>gl', '<cmd>Git log --oneline<cr>', desc = '[G]it [L]og' },
      { '<leader>gL', '<cmd>Git log<cr>', desc = '[G]it [L]og (full)' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = '[G]it [C]ommit' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },
      { '<leader>gf', '<cmd>Git fetch<cr>', desc = '[G]it [F]etch' },
      { '<leader>gF', '<cmd>Git pull<cr>', desc = '[G]it pull ([F]etch)' },
    },
  },

  -- Diffview: Advanced diff visualization
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = '[G]it diff [V]iew' },
      { '<leader>gV', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [V]iew history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it [H]istory (all)' },
      { '<leader>gx', '<cmd>DiffviewClose<cr>', desc = '[G]it diff e[X]it' },
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