# Custom Neovim Configuration

This is my personal Neovim configuration, built upon the foundation of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). While it started from that base, it has been customized to create a development environment focused on my specific workflows, particularly for **Python** and **Markdown/Obsidian**.

## Core Philosophy

This configuration is designed to be both beautiful and functional, prioritizing:

*   **Aesthetics**: Featuring [Catppuccin](https://github.com/catppuccin/nvim) theme and a statusline powered by [Lualine](https://github.com/nvim-lualine/lualine.nvim).
*   **Ergonomics**: Keybindings are organized into logical, mnemonic groups for easy access via `which-key.nvim`.
*   **Python Development**: Integrated support for virtual environments, debugging with DAP, and running tests with Neotest.
*   **Markdown & Obsidian**: A dedicated "Focus Mode" and tools for a seamless writing experience.

## Installation & Dependencies

This setup requires Neovim (stable or nightly) and several external dependencies.

*   **Base Tools**: `git`, `make`, `unzip`, C Compiler (`gcc`)
*   **Search**: `ripgrep`, `fd`
*   **Clipboard**: `xclip` (or platform equivalent)
*   **UI**: A [Nerd Font](https://www.nerdfonts.com/) is required for icons to render correctly in `neo-tree.nvim` and `lualine.nvim`.
*   **Python**: `python` and `pip`.
*   **Markdown**: `yarn` for `markdown-preview.nvim`.

Once dependencies are installed, clone this repository to your Neovim config directory (`~/.config/nvim`).

## Keybindings

Custom keybindings are organized for discoverability. The leader key is `space`.

### General & Navigation

| Keybinding | Description |
| :--- | :--- |
| `\` | Toggle file explorer |
| `<leader>fc` | Format code in current buffer |
| `<leader>tc` | **C**omment line / selection |
| `<leader>q` | Open diagnostic quickfix list |
| `<C-h/j/k/l>`| Move focus between windows |
| `<Esc>` | Clear search highlights |

### Telescope: Fuzzy Finding

| Keybinding | Description |
| :--- | :--- |
| `<leader>sf` | **S**earch **F**iles |
| `<leader>sh` | **S**earch **H**elp |
| `<leader>sw` | **S**earch current **W**ord |
| `<leader>sg` | **S**earch by **G**rep |
| `<leader>sd` | **S**earch **D**iagnostics |
| `<leader>sm` | **S**earch **M**essages |
| `<leader>sr` | **S**earch **R**esume |
| `<leader>s.` | **S**earch Recent Files |
| `<leader><leader>`| Find existing buffers |
| `<leader>/` | Fuzzily search in current buffer |

### Language Server Protocol (LSP)

| Keybinding | Description |
| :--- | :--- |
| `<leader>lr` | **R**ename Symbol |
| `<leader>la` | Code **A**ction |
| `<leader>lR` | Go to **R**eferences |
| `<leader>li` | Go to **I**mplementation |
| `<leader>ld` | Go to **D**efinition |
| `<leader>lD` | Go to **D**eclaration |
| `<leader>lt` | Go to **T**ype Definition |
| `<leader>ls` | Document **S**ymbols |
| `<leader>lw` | **W**orkspace Symbols |
| `<leader>th` | **T**oggle Inlay **H**ints |

### Git (Gitsigns)

| Keybinding | Description |
| :--- | :--- |
| `]h` / `[h` | Next / Previous Hunk |
| `<leader>gs` | **S**tage Hunk |
| `<leader>gr` | **R**eset Hunk |
| `<leader>gp` | **P**review Hunk |

### Flash: Fast Navigation

| Keybinding | Description |
| :--- | :--- |
| `<leader>fs` | **F**lash **S**earch |
| `<leader>fr` | **F**lash **R**emote Search |
| `<leader>ft` | **F**lash **T**reesitter Jump |
| `<leader>fT` | **F**lash **T**reesitter Search |
| `<leader>fo` | **F**lash **O**ptions |

### Harpoon: Bookmarking

| Keybinding | Description |
| :--- | :--- |
| `<leader>ha` | **A**dd file to harpoon list |
| `<leader>he` | Toggle **E**xplorer (quick menu) |
| `<leader>1-5`| Jump to file 1-5 in the list |

### Python Virtual Environment

| Keybinding | Description |
| :--- | :--- |
| `<leader>vc` | **V**env **C**hoose |
| `<leader>vs` | **V**env **S**elect Cached |

### Python Debugging & Testing (DAP)

| Keybinding | Description |
| :--- | :--- |
| `<leader>dt` | **T**oggle Breakpoint |
| `<leader>dc` | **C**ontinue execution |
| `<leader>do` | Step **O**ver |
| `<leader>di` | Step **I**nto |
| `<leader>du` | Step O**u**t |
| `<leader>db` | **R**un to **B**uffer Line |
| `<leader>dl` | Run **L**ast session |
| `<leader>d-t` | Hover **T**ooltip |
| `<leader>d-p` | **P**review Widget |
| `<leader>d-f` | **F**ocus Widget |
| `<leader>d-e` | **E**xit Widget |
| `<leader>dr` | **R**EPL Toggle |
| `<leader>dk` | **K**ill Session |
| `<leader>dpm`| Test **P**ython **M**ethod |
| `<leader>dpc`| Test **P**ython **C**lass |

### Obsidian

| Keybinding | Description |
| :--- | :--- |
| `gf` | **G**oto **F**ile under cursor |
| `<leader>ch` | Toggle **C**heckbox |
| `<leader>o` | **O**pen note in OS application |

### Markdown Focus Mode

| Keybinding | Description |
| :--- | :--- |
| `<leader>tz` | Toggle **Z**en Mode |
| `<leader>tt` | Toggle **T**wilight |
| `<leader>tp` | Toggle **P**encil Mode |
| `<leader>ts` | Toggle **S**pell Check |

### Augment Code

| Keybinding | Description |
| :--- | :--- |
| `<leader>ac` | **A**ugment **C**hat |
| `<leader>an` | **A**ugment **N**ew Chat |
| `<leader>at` | **A**ugment **T**oggle Chat |

