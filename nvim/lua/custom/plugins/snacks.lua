-- =============================================================================
-- SNACKS.NVIM - Consolidated QoL modules
-- =============================================================================
-- Replaces: toggleterm, zen-mode, twilight, lazygit.nvim, fidget, dashboard-nvim
-- Adds:     bufdelete, rename, statuscolumn, gitbrowse, bigfile, quickfile,
--           words, input, indent, toggle, scroll

local quotes = {
  { "First, solve the problem. Then, write the code.", "John Johnson" },
  { "Code is like humor. When you have to explain it, it's bad.", "Cory House" },
  { "Make it work, make it right, make it fast.", "Kent Beck" },
  { "Clean code always looks like it was written by someone who cares.", "Robert C. Martin" },
  { "Programming isn't about what you know; it's about what you can figure out.", "Chris Pine" },
  { "The best error message is the one that never shows up.", "Thomas Fuchs" },
  { "Simplicity is the soul of efficiency.", "Austin Freeman" },
  { "Programs must be written for people to read, and only incidentally for machines to execute.", "Harold Abelson" },
  { "Any fool can write code that a computer can understand. Good programmers write code that humans can understand.", "Martin Fowler" },
  { "The most damaging phrase in the language is 'We've always done it this way.'", "Grace Hopper" },
  { "Truth can only be found in one place: the code.", "Robert C. Martin" },
  { "A language that doesn't affect the way you think about programming is not worth knowing.", "Alan Perlis" },
  { "Debugging is twice as hard as writing the code in the first place.", "Brian Kernighan" },
  { "It's not a bug – it's an undocumented feature.", "Anonymous" },
  { "The only way to learn a new programming language is by writing programs in it.", "Dennis Ritchie" },
  { "Perfection is achieved not when there is nothing more to add, but rather when there is nothing more to take away.", "Antoine de Saint-Exupéry" },
  { "One of my most productive days was throwing away 1000 lines of code.", "Ken Thompson" },
  { "Deleted code is debugged code.", "Jeff Sickel" },
  { "Talk is cheap. Show me the code.", "Linus Torvalds" },
  { "Most good programmers do programming not because they expect to get paid, but because it is fun to program.", "Linus Torvalds" },
  { "There are only two hard things in Computer Science: cache invalidation and naming things.", "Phil Karlton" },
  { "Nine people can't make a baby in a month.", "Fred Brooks" },
  { "Good code is its own best documentation.", "Steve McConnell" },
  { "I'm not a great programmer; I'm just a good programmer with great habits.", "Kent Beck" },
  { "Optimism is an occupational hazard of programming; feedback is the treatment.", "Kent Beck" },
  { "Simplicity is prerequisite for reliability.", "Edsger Dijkstra" },
  { "The art of programming is the art of organizing complexity.", "Edsger Dijkstra" },
  { "Programming is thinking, not typing.", "Casey Patton" },
  { "Code never lies, comments sometimes do.", "Ron Jeffries" },
  { "Don't comment bad code — rewrite it.", "Brian Kernighan" },
  { "Premature optimization is the root of all evil.", "Donald Knuth" },
  { "It works on my machine.", "Every Developer" },
  { "Controlling complexity is the essence of computer programming.", "Brian Kernighan" },
  { "A clever person solves a problem. A wise person avoids it.", "Albert Einstein" },
  { "The best code is no code at all.", "Jeff Atwood" },
  { "Fast, good, cheap: pick any two.", "Anonymous" },
  { "Unix is simple. It just takes a genius to understand its simplicity.", "Dennis Ritchie" },
  { "Do one thing, do it well.", "Unix Philosophy" },
  { "To iterate is human, to recurse divine.", "L. Peter Deutsch" },
  { "Stay hungry, stay foolish.", "Steve Jobs" },
  { "The only way to do great work is to love what you do.", "Steve Jobs" },
  { "Simplicity is the ultimate sophistication.", "Leonardo da Vinci" },
  { "If you can't explain it simply, you don't understand it well enough.", "Albert Einstein" },
  { "Everything should be made as simple as possible, but not simpler.", "Albert Einstein" },
  { "Done is better than perfect.", "Sheryl Sandberg" },
  { "The best time to plant a tree was 20 years ago. The second best time is now.", "Chinese Proverb" },
  { "I have not failed. I've just found 10,000 ways that won't work.", "Thomas Edison" },
  { "Beware of bugs in the above code; I have only proved it correct, not tried it.", "Donald Knuth" },
  { "A user interface is like a joke. If you have to explain it, it's not that good.", "Martin LeBlanc" },
  { "The cheapest, fastest, and most reliable components are those that aren't there.", "Gordon Bell" },
  { "I love deadlines. I like the whooshing sound they make as they fly by.", "Douglas Adams" },
  { "Hardware eventually fails. Software eventually works.", "Michael Hartung" },
  { "Adding manpower to a late software project makes it later.", "Fred Brooks" },
  { "Testing can prove the presence of bugs, but not their absence.", "Edsger Dijkstra" },
  { "There are only two kinds of languages: the ones people complain about and the ones nobody uses.", "Bjarne Stroustrup" },
  { "There are no solutions, only trade-offs.", "Thomas Sowell" },
  { "Shipping is a feature. A really important feature.", "Joel Spolsky" },
}

math.randomseed(os.time())
local quote = quotes[math.random(#quotes)]

local dashboard_header = table.concat({
  '',
  '    ╔═══════════════════════════════════════════╗',
  '    ║                                           ║',
  '    ║   ░▒▓████████████████████████████████▓▒░  ║',
  '    ║                                           ║',
  '    ╚═══════════════════════════════════════════╝',
}, '\n')

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- Infra / pure upgrades
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },

      -- Notifications (replaces fidget)
      notifier = { enabled = true, timeout = 3000 },
      input = { enabled = true },

      -- Editor features
      bufdelete = { enabled = true },
      rename = { enabled = true },
      words = { enabled = true },
      gitbrowse = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },

      -- Modes (replace zen-mode + twilight)
      zen = { enabled = true },
      dim = { enabled = true },

      -- Toggles API (backs <leader>x* bindings below)
      toggle = { enabled = true },

      -- Dashboard (replaces dashboard-nvim)
      dashboard = {
        width = 60,
        preset = {
          header = dashboard_header,
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File',    action = ':Telescope find_files' },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
            { icon = ' ', key = 'w', desc = 'Find Word',    action = ':Telescope live_grep' },
            { icon = ' ', key = 'h', desc = 'Harpoon',      action = function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end },
            { icon = ' ', key = 'g', desc = 'LazyGit',      action = function() Snacks.lazygit() end },
            { icon = ' ', key = 'j', desc = 'Jujutsu',      action = ':LazyJJ' },
            { icon = ' ', key = 'c', desc = 'Config',       action = function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy',         action = ':Lazy' },
            { icon = ' ', key = 'q', desc = 'Quit',         action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { text = { { '"' .. quote[1] .. '"', hl = 'Comment' } }, align = 'center', padding = { 2, 0 } },
          { text = { { '— ' .. quote[2], hl = 'Comment' } },       align = 'center', padding = { 0, 1 } },
          { text = { { '─────  ' .. os.date('%A, %B %d') .. '  ─────', hl = 'NonText' } }, align = 'center', padding = 1 },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
    keys = {
      -- Terminal (replaces toggleterm)
      { '<C-\\>',      function() Snacks.terminal() end,                                                      mode = { 'n', 't' }, desc = 'Toggle terminal (float)' },
      { '<leader>t',   function() Snacks.terminal(nil, { win = { position = 'bottom', height = 0.3 } }) end,  mode = { 'n', 't' }, desc = 'Toggle [T]erminal (bottom)' },

      -- LazyGit (replaces lazygit.nvim)
      { '<leader>gg',  function() Snacks.lazygit() end,          desc = '[G]it: Lazy[G]it' },
      { '<leader>gf',  function() Snacks.lazygit.log_file() end, desc = '[G]it: [F]ile history' },
      { '<leader>gl',  function() Snacks.lazygit.log() end,      desc = '[G]it: [L]og' },

      -- Gitbrowse (new)
      { '<leader>go',  function() Snacks.gitbrowse() end, mode = { 'n', 'v' }, desc = '[G]it: [O]pen in browser' },

      -- LSP-aware file rename (new gap-filler)
      { '<leader>cn',  function() Snacks.rename.rename_file() end, desc = '[C]ode: Re[N]ame file' },

      -- Buffer delete preserving window layout (new gap-filler)
      { '<leader>bd',  function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
      { '<leader>bD',  function() Snacks.bufdelete.all() end, desc = '[B]uffer [D]elete all' },

      -- Notifier history (<leader>fn is already Find Neovim config)
      { '<leader>fN',  function() Snacks.notifier.show_history() end, desc = '[F]ind: [N]otifications' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- <leader>x* toggles via snacks.toggle (auto-registers with which-key)
          Snacks.toggle.diagnostics():map('<leader>xd')
          Snacks.toggle.option('spell',      { name = 'Spelling' }):map('<leader>xs')
          Snacks.toggle.option('wrap',       { name = 'Wrap' }):map('<leader>xw')
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>xb')
          Snacks.toggle.zen():map('<leader>xz')
          Snacks.toggle.dim():map('<leader>xD')
          Snacks.toggle.inlay_hints():map('<leader>xh')
          Snacks.toggle.line_number():map('<leader>xL')
        end,
      })
    end,
  },
}
