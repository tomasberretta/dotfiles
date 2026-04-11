-- =============================================================================
-- LEAN NEOVIM KEYMAPS
-- =============================================================================
-- Streamlined keybinding system with 9 mnemonic prefixes
-- Leader key: <Space>
--
-- PREFIXES:
--   f = Find       (files, grep, buffers, symbols)
--   c = Code       (LSP, refactor, format, actions)
--   g = Git        (lazygit, gitsigns)
--   j = Jujutsu    (lazyjj)
--   r = Run        (test, debug, python venv)
--   h = Harpoon    (file bookmarks)
--   x = Toggle     (theme, lint, hints, zen, spell)
--   u = Utils      (dev toolkit, notes, HTTP)
--   a = AI         (AI assistance)
--
-- QUICK ACCESS (no prefix):
--   \             = Explorer (Yazi)
--   <leader><leader> = Find buffers
--   <leader>/     = Search in buffer
--   s / S         = Flash jump
--   <C-\>         = Terminal
--   F5-F12        = Debug stepping

-- =============================================================================
-- ESSENTIAL VIM IMPROVEMENTS
-- =============================================================================

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Previous error' })
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next error' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- =============================================================================
-- QUALITY OF LIFE
-- =============================================================================

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search (centered)' })

vim.keymap.set('n', '<C-Left>', 'b', { desc = 'Word backward' })
vim.keymap.set('n', '<C-Right>', 'w', { desc = 'Word forward' })
vim.keymap.set('i', '<C-Left>', '<C-o>b', { desc = 'Word backward' })
vim.keymap.set('i', '<C-Right>', '<C-o>w', { desc = 'Word forward' })

vim.keymap.set('n', '<Home>', '^', { desc = 'First non-blank' })
vim.keymap.set('i', '<Home>', '<C-o>^', { desc = 'First non-blank' })

-- =============================================================================
-- CODE OPERATIONS (<leader>c)
-- =============================================================================

vim.keymap.set('n', '<leader>cl', 'yyp', { desc = '[C]ode: Duplicate [L]ine' })
vim.keymap.set('v', '<leader>cl', 'y`>p', { desc = '[C]ode: Duplicate [L]ine' })
vim.keymap.set('n', '<leader>cL', 'yyP', { desc = '[C]ode: Duplicate [L]ine above' })
vim.keymap.set('n', '<leader>cx', '"_dd', { desc = '[C]ode: Delete line (no register)' })
vim.keymap.set('v', '<leader>cx', '"_d', { desc = '[C]ode: Delete (no register)' })
vim.keymap.set('n', '<leader>cj', 'J', { desc = '[C]ode: [J]oin lines' })
vim.keymap.set('n', '<leader>co', 'o<Esc>', { desc = '[C]ode: [O]pen line below' })
vim.keymap.set('n', '<leader>cO', 'O<Esc>', { desc = '[C]ode: [O]pen line above' })

-- =============================================================================
-- TOGGLE OPTIONS (<leader>x)
-- =============================================================================

vim.keymap.set('n', '<leader>xd', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  vim.notify(vim.diagnostic.is_enabled() and 'Diagnostics ON' or 'Diagnostics OFF')
end, { desc = 'Toggle [D]iagnostics' })
vim.keymap.set('n', '<leader>xw', '<cmd>set wrap!<cr>', { desc = 'Toggle [W]rap' })
vim.keymap.set('n', '<leader>xs', function()
  vim.opt.spell = not vim.opt.spell:get()
  vim.notify(vim.opt.spell:get() and 'Spell check ON' or 'Spell check OFF')
end, { desc = 'Toggle [S]pell check' })

-- =============================================================================
-- QUICK ACCESS (single keys after leader)
-- =============================================================================

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line [E]rrors' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix' })

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>W', '<cmd>wa<cr>', { desc = '[W]rite all' })
vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = '[Q]uit all' })

vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
