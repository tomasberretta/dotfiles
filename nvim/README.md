# Custom Neovim Configuration

This is my personal Neovim configuration, built upon the foundation of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It has evolved into a highly customized development environment optimized for **Python**, **Markdown**, and general programming workflows.

## 🎯 Core Philosophy

This configuration prioritizes:
- **Organization**: Modular plugin structure organized by functionality
- **Ergonomics**: Mnemonic keybinding system with consistent prefixes
- **Performance**: Lazy loading and optimized startup time
- **Aesthetics**: Dual theme system (minimal dark / oxocarbon light)
- **IDE Features**: Full IDE capabilities while maintaining Vim efficiency

## 📦 Plugin Organization

Plugins are organized into logical modules in `lua/custom/plugins/`:

| Module | Purpose |
|--------|---------|
| `core.lua` | Essential utilities and dependencies |
| `ui.lua` | Themes and UI enhancements |
| `treesitter.lua` | Syntax highlighting and text objects |
| `lsp.lua` | Language servers and formatting |
| `completion.lua` | Autocompletion with Blink.cmp |
| `telescope.lua` | Fuzzy finding everything |
| `navigation.lua` | File explorer, bookmarks, quick jumps |
| `editing.lua` | Advanced editing, refactoring, comments |
| `git.lua` | Complete git integration |
| `debugging.lua` | Debug Adapter Protocol setup |
| `python.lua` | Python-specific tools |
| `terminal.lua` | Integrated terminal |
| `writing.lua` | Markdown and focus modes |

## 🛠️ Installation & Dependencies

### Required Dependencies

**System Tools:**
- `git`, `make`, `unzip`, C Compiler (`gcc`)
- `ripgrep` (rg) - for searching
- `fd` - for file finding
- `xclip` or platform equivalent - for clipboard
- A [Nerd Font](https://www.nerdfonts.com/) - for icons

**Language-Specific:**
- `node` & `npm` - for LSP servers
- `python` & `pip` - for Python development
- `yarn` - for markdown preview

### Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone <your-repo> ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

## ⌨️ Keybinding System

The configuration uses a mnemonic system where the first letter after `<leader>` indicates the category.

### Leader Key: `<space>`

### 🔍 Search & Find (`<leader>s`)

| Key | Description |
|-----|-------------|
| `<leader>sf` | **S**earch **F**iles |
| `<leader>sg` | **S**earch by **G**rep |
| `<leader>sw` | **S**earch current **W**ord |
| `<leader>sb` | **S**earch **B**uffers |
| `<leader>sh` | **S**earch **H**elp |
| `<leader>sk` | **S**earch **K**eymaps |
| `<leader>sd` | **S**earch **D**iagnostics |
| `<leader>sm` | **S**earch **M**essages |
| `<leader>s.` | **S**earch recent files |
| `<leader>sr` | **S**earch & **R**eplace (Spectre) |
| `<leader>sR` | **S**earch **R**esume last |
| `<leader>/` | Search in current buffer |
| `<leader><leader>` | Find buffers |

### 💡 LSP (`<leader>l`)

| Key | Description |
|-----|-------------|
| `<leader>la` | Code **A**ction |
| `<leader>lr` | **R**eferences |
| `<leader>lR` | **R**ename symbol |
| `<leader>ld` | Go to **D**efinition |
| `<leader>lD` | Go to **D**eclaration |
| `<leader>li` | Go to **I**mplementation |
| `<leader>lt` | Go to **T**ype definition |
| `<leader>ls` | Document **S**ymbols |
| `<leader>lw` | **W**orkspace symbols |
| `K` | Hover documentation |

### 📁 File Explorer (`<leader>e`)

| Key | Description |
|-----|-------------|
| `<leader>e` | **E**xplore files (Oil) |
| `<leader>E` | **E**xplore files (float) |
| `\` | Quick file explorer |

**In Oil buffer:**
- `-` - Parent directory
- `<CR>` - Open file/directory
- `<C-v>` - Open in vertical split
- `<C-x>` - Open in horizontal split
- `g.` - Toggle hidden files
- `g?` - Show help

### 🎯 Harpoon (`<leader>h`)

| Key | Description |
|-----|-------------|
| `<leader>ha` | **H**arpoon **A**dd file |
| `<leader>he` | **H**arpoon **E**xplorer |
| `<leader>1-5` | Jump to harpooned file 1-5 |

### 🐙 Git (`<leader>g`)

| Key | Description |
|-----|-------------|
| `<leader>gg` | Git status (Fugitive) |
| `<leader>gs` | **S**tage hunk |
| `<leader>gr` | **R**eset hunk |
| `<leader>gS` | **S**tage buffer |
| `<leader>gu` | **U**ndo stage |
| `<leader>gp` | **P**review hunk |
| `<leader>gb` | **B**lame line |
| `<leader>gB` | Toggle **B**lame |
| `<leader>gd` | **D**iff this |
| `<leader>gD` | **D**iff against HEAD |
| `<leader>gl` | **L**og |
| `<leader>gc` | **C**ommit |
| `<leader>gP` | **P**ush |
| `<leader>gf` | **F**etch |
| `<leader>gv` | Diff **V**iew |
| `<leader>gV` | File **V**iew history |
| `]c` / `[c` | Next/Previous change |

### 🐛 Debug (`<leader>d`)

| Key | Description |
|-----|-------------|
| `<leader>db` | Toggle **B**reakpoint |
| `<leader>dB` | **B**reakpoint conditional |
| `<leader>dc` | **C**ontinue |
| `<leader>di` | Step **I**nto |
| `<leader>do` | Step **O**ver |
| `<leader>dO` | Step **O**ut |
| `<leader>dr` | **R**EPL toggle |
| `<leader>dl` | Run **L**ast |
| `<leader>dk` | **K**ill session |
| `<leader>du` | Debug **U**I toggle |
| `<leader>de` | **E**val expression |
| **Python specific:** ||
| `<leader>dpm` | Test **M**ethod |
| `<leader>dpc` | Test **C**lass |

### 🔧 Refactor (`<leader>r`)

| Key | Description |
|-----|-------------|
| `<leader>rf` | Extract **F**unction |
| `<leader>rv` | Extract **V**ariable |
| `<leader>ri` | **I**nline variable |
| `<leader>rb` | Extract **B**lock |
| `<leader>rr` | Show **R**efactorings |

### 🐍 Python (`<leader>v`)

| Key | Description |
|-----|-------------|
| `<leader>vs` | **V**env **S**elect |
| `<leader>vc` | **V**env **C**ached |

### 🧪 Testing (`<leader>t`)

| Key | Description |
|-----|-------------|
| `<leader>tr` | Test **R**un nearest |
| `<leader>tR` | Test **R**un file |
| `<leader>td` | Test **D**ebug |
| `<leader>ts` | Test **S**top |
| `<leader>to` | Test **O**utput |
| `<leader>tS` | Test **S**ummary |

### 💻 Terminal (`<leader>T`)

| Key | Description |
|-----|-------------|
| `<C-\>` | Toggle terminal |
| `<leader>Tf` | Terminal **F**loat |
| `<leader>Th` | Terminal **H**orizontal |
| `<leader>Tv` | Terminal **V**ertical |
| `<leader>Tg` | Terminal Lazy**G**it |

### ✍️ Writing/Zen (`<leader>z`)

| Key | Description |
|-----|-------------|
| `<leader>zz` | Toggle **Z**en mode |
| `<leader>zt` | Toggle **T**wilight |
| `<leader>zp` | Toggle **P**encil |
| `<leader>zs` | Toggle **S**pell check |
| `<leader>zm` | **M**arkdown preview |

### 📐 Buffer Management (`<leader>b`)

| Key | Description |
|-----|-------------|
| `<leader>bn` | Buffer **N**ext |
| `<leader>bp` | Buffer **P**revious |
| `<leader>bc` | Buffer **C**lose |
| `<leader>ba` | Buffer **A**lternate |
| `<leader>bl` | Buffer **L**ist |
| `<A-Left/Right>` | Previous/Next buffer |
| `<C-Tab>` | Last buffer |

### 🪟 Window Management (`<leader>w`)

| Key | Description |
|-----|-------------|
| `<leader>ws` | Window **S**plit horizontal |
| `<leader>wv` | Window **V**ertical split |
| `<leader>wc` | Window **C**lose |
| `<leader>wo` | Window **O**nly |
| `<leader>w=` | Window balance |
| `<C-h/j/k/l>` | Navigate windows |

### 📝 Code Operations (`<leader>c`)

| Key | Description |
|-----|-------------|
| `<leader>cd` | Code **D**uplicate line |
| `<leader>cx` | Code delete (no clipboard) |
| `<leader>cj` | Code **J**oin lines |
| `<leader>co` | Code **O**pen line below |
| `<leader>cO` | Code **O**pen line above |
| `<leader>c>` | Code indent |
| `<leader>c<` | Code outdent |
| `<leader>cs` | Code **S**ubstitute word |
| `gc` | Comment toggle |
| `gb` | Comment block |

### 🎨 UI/Toggles (`<leader>u`)

| Key | Description |
|-----|-------------|
| `<leader>ut` | Toggle **T**heme (dark/light) |

### 📂 File Operations (`<leader>f`)

| Key | Description |
|-----|-------------|
| `<leader>fc` | **F**ormat **C**ode |
| `<leader>fn` | **F**ile **N**ew |
| `<leader>fs` | **F**ile **S**ave |
| `<leader>fS` | **F**ile **S**ave all |
| `<leader>fq` | **F**ile **Q**uit |
| `<leader>fQ` | **F**ile **Q**uit all |

### 🏃 Navigation (`<leader>n`)

| Key | Description |
|-----|-------------|
| `<leader>nb` | **N**avigate **B**ack |
| `<leader>nf` | **N**avigate **F**orward |
| `<leader>nl` | **N**avigate jump **L**ist |
| `<leader>nm` | **N**avigate **M**arks |

### ⚡ Quick Navigation

| Key | Description |
|-----|-------------|
| `s` | Flash search |
| `S` | Flash treesitter |
| `<C-n>` | Multi-cursor add |
| `<A-j/k>` | Move line down/up |
| `gsa` | Add surrounding |
| `gsd` | Delete surrounding |
| `gsr` | Replace surrounding |
| `jk` or `kj` | Exit insert mode |

## 🎨 Themes

The configuration includes a dual theme system:
- **Dark**: Minimal theme
- **Light**: Oxocarbon theme

Toggle with `<leader>ut`. The theme syncs with your terminal (ghostty/tmux).

## 🔧 LSP Servers

LSP servers are automatically installed via Mason. Common ones include:
- **Lua**: `lua_ls`
- **Python**: `pyright`, `ruff`
- **JavaScript/TypeScript**: `ts_ls`, `eslint`
- **And more...**

To install additional servers:
1. Run `:Mason`
2. Find and install servers with `i`
3. Configure in `lua/custom/plugins/lsp.lua`

## 📝 Customization

### Adding Plugins
Create a new file in `lua/custom/plugins/` or add to an existing category file.

### Modifying Keybindings
- Core keymaps: `lua/custom/keymaps.lua`
- Plugin keymaps: In respective plugin files

### Theme Customization
- Theme config: `lua/custom/theme.lua`
- Current theme: `lua/custom/current-theme.lua`

## 🚀 Tips

1. **Which-key**: Press `<leader>` and wait to see available keybindings
2. **Telescope**: Most searches support fuzzy finding
3. **Oil.nvim**: Edit filesystem like a buffer - make changes and save
4. **Flash**: Press `s` for lightning-fast navigation
5. **Harpoon**: Mark frequently used files for instant access

## 🐛 Troubleshooting

- Run `:checkhealth` to diagnose issues
- Run `:Lazy` to manage plugins
- Run `:Mason` to manage LSP servers
- Check `:messages` for error details

## 📚 Learning Resources

- `:Tutor` - Built-in Vim tutorial
- `:help` - Comprehensive help system
- `<leader>sh` - Search help topics
- `<leader>sk` - Search keymaps

---

*Built with ❤️ on top of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)*