-- =============================================================================
-- IDE-STYLE KEYMAPS
-- =============================================================================
-- Enhanced keymaps that provide IDE-like functionality following mnemonic system

-- Navigation keymaps (following [N]avigation pattern)
vim.keymap.set("n", "<leader>nb", "<C-o>", { desc = "[N]avigate [B]ack (jump list)" })
vim.keymap.set("n", "<leader>nf", "<C-i>", { desc = "[N]avigate [F]orward (jump list)" })
vim.keymap.set("n", "<leader>nl", "<cmd>jumps<cr>", { desc = "[N]avigate jump [L]ist" })
vim.keymap.set("n", "<leader>nm", "<cmd>marks<cr>", { desc = "[N]avigate [M]arks" })
vim.keymap.set("n", "<leader>n.", "g;", { desc = "[N]avigate Last [.]change" })
vim.keymap.set("n", "<leader>n,", "g,", { desc = "[N]avigate Next [,]change" })

-- Enhanced buffer switching (previous file like IDEs)
vim.keymap.set("n", "<A-Left>", "<cmd>bprev<cr>", { desc = "Previous buffer (Alt+Left)" })
vim.keymap.set("n", "<A-Right>", "<cmd>bnext<cr>", { desc = "Next buffer (Alt+Right)" })
vim.keymap.set("n", "<C-Tab>", "<cmd>b#<cr>", { desc = "Switch to last buffer (like IDE)" })
vim.keymap.set("n", "<leader>ba", "<cmd>b#<cr>", { desc = "[B]uffer [A]lternate (last)" })

-- Buffer management (following [B]uffer pattern)
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "[B]uffer [C]lose" })
vim.keymap.set("n", "<leader>bC", "<cmd>%bdelete|edit#|bdelete#<cr>", { desc = "[B]uffer [C]lose All Others" })
vim.keymap.set("n", "<leader>bl", "<cmd>ls<cr>", { desc = "[B]uffer [L]ist" })

-- Code actions (following [C]ode pattern)
vim.keymap.set("n", "<leader>cd", "yyp", { desc = "[C]ode [D]uplicate Line" })
vim.keymap.set("v", "<leader>cd", "y`>p", { desc = "[C]ode [D]uplicate Selection" })
vim.keymap.set("n", "<leader>cD", "yyP", { desc = "[C]ode [D]uplicate Line Above" })
vim.keymap.set("n", "<leader>cx", '"_dd', { desc = "[C]ode Delete Line (no clipboard)" })
vim.keymap.set("v", "<leader>cx", '"_d', { desc = "[C]ode Delete Selection (no clipboard)" })
vim.keymap.set("n", "<leader>cj", "J", { desc = "[C]ode [J]oin Lines" })
vim.keymap.set("n", "<leader>co", "o<Esc>", { desc = "[C]ode [O]pen Line Below" })
vim.keymap.set("n", "<leader>cO", "O<Esc>", { desc = "[C]ode [O]pen Line Above" })
vim.keymap.set("n", "<leader>c>", ">>", { desc = "[C]ode Indent [>]" })
vim.keymap.set("n", "<leader>c<", "<<", { desc = "[C]ode Outdent [<]" })
vim.keymap.set("v", "<leader>c>", ">gv", { desc = "[C]ode Indent [>]" })
vim.keymap.set("v", "<leader>c<", "<gv", { desc = "[C]ode Outdent [<]" })

-- File operations (extending your [F]ormat pattern)
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "[F]ile [N]ew" })
-- Removed file save keybindings - use :w manually
vim.keymap.set("n", "<leader>fq", "<cmd>q<cr>", { desc = "[F]ile [Q]uit" })
vim.keymap.set("n", "<leader>fQ", "<cmd>qa<cr>", { desc = "[F]ile [Q]uit All" })

-- Window management (following [W]indow pattern)
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "[W]indow [S]plit Horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "[W]indow [V]ertical Split" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "[W]indow [C]lose" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "[W]indow [O]nly (close others)" })
vim.keymap.set("n", "<leader>ww", "<C-w>w", { desc = "[W]indow [W]alk to Next" })
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "[W]indow [R]otate" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow [=]Balance" })

-- Better escape sequences (common in IDEs)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- Word navigation like IDEs
vim.keymap.set("n", "<C-Left>", "b", { desc = "Move word backward" })
vim.keymap.set("n", "<C-Right>", "w", { desc = "Move word forward" })
vim.keymap.set("i", "<C-Left>", "<C-o>b", { desc = "Move word backward in insert" })
vim.keymap.set("i", "<C-Right>", "<C-o>w", { desc = "Move word forward in insert" })

-- Home/End behavior like IDEs
vim.keymap.set("n", "<Home>", "^", { desc = "Go to first non-blank character" })
vim.keymap.set("i", "<Home>", "<C-o>^", { desc = "Go to first non-blank character" })
vim.keymap.set("n", "<End>", "$", { desc = "Go to end of line" })
vim.keymap.set("i", "<End>", "<C-o>$", { desc = "Go to end of line" })

-- Page up/down with cursor centering (smoother experience)
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })

-- Search with centering (better UX)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Better line selection
vim.keymap.set("n", "vv", "V", { desc = "Select entire line" })

-- IDE-style line manipulation
vim.keymap.set("n", "<C-S-k>", "yyP", { desc = "Duplicate line above" })
vim.keymap.set("n", "<C-S-j>", "yyp", { desc = "Duplicate line below" })
vim.keymap.set("i", "<C-S-k>", "<Esc>yyPa", { desc = "Duplicate line above (insert)" })
vim.keymap.set("i", "<C-S-j>", "<Esc>yypa", { desc = "Duplicate line below (insert)" })

-- Quick substitution (powerful find/replace)
vim.keymap.set("n", "<leader>cs", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "[C]ode [S]ubstitute word under cursor" })
vim.keymap.set("v", "<leader>cs", ":s/", { desc = "[C]ode [S]ubstitute in selection" })

-- Select all (common IDE shortcut)
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Quick access to config (common in IDEs)
vim.keymap.set("n", "<leader>fed", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "[F]ile [E]dit [D]otfiles (init.lua)" })

-- Additional helpful shortcuts
vim.keymap.set("n", "<leader>fR", "<cmd>source %<cr>", { desc = "[F]ile [R]eload/Source" })
vim.keymap.set("n", "<leader>fw", "<cmd>set wrap!<cr>", { desc = "[F]ile toggle [W]rap" })
