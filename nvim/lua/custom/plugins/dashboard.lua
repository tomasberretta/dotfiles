-- =============================================================================
-- DASHBOARD - Home screen with quotes and system info
-- =============================================================================

return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
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

      local header = {
        [[                                                     ]],
        [[                                                     ]],
        [[    ╔═══════════════════════════════════════════╗    ]],
        [[    ║                                           ║    ]],
        [[    ║   ░▒▓████████████████████████████████▓▒░  ║    ]],
        [[    ║                                           ║    ]],
        [[    ╚═══════════════════════════════════════════╝    ]],
        [[                                                     ]],
      }

      math.randomseed(os.time())
      local random_quote = quotes[math.random(#quotes)]

      local function get_cpu()
        local cpu = vim.fn.system("top -l 1 | grep 'CPU usage' | awk '{print $3}' 2>/dev/null"):gsub('%%', ''):gsub('%s+', '')
        if cpu ~= '' then
          return string.format('%.0f', tonumber(cpu) or 0) .. '%'
        end
        return '—'
      end

      local function get_memory()
        local mem = vim.fn.system("memory_pressure | head -1 | awk '{print $4}' 2>/dev/null"):gsub('%%', ''):gsub('%s+', '')
        if mem ~= '' and tonumber(mem) then
          return string.format('%.0f', 100 - tonumber(mem)) .. '%'
        end
        local pages = vim.fn.system("vm_stat | grep 'Pages active' | awk '{print $3}' 2>/dev/null"):gsub('[^0-9]', '')
        if pages ~= '' and tonumber(pages) then
          local gb = (tonumber(pages) * 4096) / (1024 * 1024 * 1024)
          return string.format('%.1fG', gb)
        end
        return '—'
      end

      local function get_uptime()
        local uptime = vim.fn.system("uptime | sed 's/.*up //' | sed 's/,.*//' 2>/dev/null"):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
        if uptime ~= '' then
          return uptime
        end
        return '—'
      end

      local function build_header()
        local result = vim.deepcopy(header)

        table.insert(result, '')
        table.insert(result, '  "' .. random_quote[1] .. '"')
        table.insert(result, string.rep(' ', 40) .. '— ' .. random_quote[2])
        table.insert(result, '')

        local date_line = '─────  ' .. os.date('%A, %B %d') .. '  ─────'
        local padding = string.rep(' ', math.floor((60 - #date_line) / 2))
        table.insert(result, padding .. date_line)
        table.insert(result, '')
        table.insert(result, '')
        table.insert(result, '')
        table.insert(result, '')

        -- local cpu = get_cpu()
        -- local mem = get_memory()
        -- local uptime = get_uptime()
        -- local stats = '  CPU ' .. cpu .. '   │    RAM ' .. mem .. '   │   ⏱ ' .. uptime
        -- table.insert(result, stats)
        -- table.insert(result, '')

        return result
      end

      require('dashboard').setup {
        theme = 'doom',
        hide = {
          statusline = true,
          tabline = true,
          winbar = true,
        },
        config = {
          header = build_header(),
          center = {
            { icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
            { icon = '  ', desc = 'Recent Files', key = 'r', action = 'Telescope oldfiles' },
            { icon = '  ', desc = 'Find Word', key = 'w', action = 'Telescope live_grep' },
            { icon = '  ', desc = 'Harpoon', key = 'h', action = function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end },
            { icon = '  ', desc = 'Git', key = 'g', action = 'LazyGit' },
            { icon = '  ', desc = 'Jujutsu', key = 'j', action = 'LazyJJ' },
            { icon = '  ', desc = 'Config', key = 'c', action = function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end },
            { icon = '󰒲  ', desc = 'Lazy', key = 'l', action = 'Lazy' },
            { icon = '  ', desc = 'Quit', key = 'q', action = 'qa' },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '', '⚡ ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#7EB7E6' })
      vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#94DD8E' })
      vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#F9E154', bold = true })
      vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#DFE0EA' })
      vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#515669', italic = true })
    end,
  },
}
