# Neovim Keymaps - Lean Structure

**Leader key**: `<Space>`

## 9 Mnemonic Prefixes

| Prefix | Category | Mnemonic |
|--------|----------|----------|
| `<leader>f` | **Find** | Find anything |
| `<leader>c` | **Code** | Code operations |
| `<leader>g` | **Git** | Git operations (lazygit) |
| `<leader>j` | **Jujutsu** | Jujutsu VCS (lazyjj) |
| `<leader>r` | **Run** | Run/execute (test, debug, python) |
| `<leader>h` | **Harpoon** | File bookmarks |
| `<leader>x` | **Toggle** | Toggle options |
| `<leader>u` | **Utils** | Dev utilities |
| `<leader>a` | **AI** | AI assistance |

---

## Find (`<leader>f`)

| Key | Description |
|-----|-------------|
| `ff` | Find files |
| `fg` | Find by grep |
| `fw` | Find word under cursor |
| `fb` | Find buffers |
| `f.` | Find recent files |
| `fh` | Find help |
| `fk` | Find keymaps |
| `fd` | Find diagnostics |
| `fm` | Find messages |
| `fn` | Find neovim config |
| `fo` | Find in open files |
| `fr` | Find & replace (Spectre) |
| `fR` | Find resume last |

## Code (`<leader>c`)

| Key | Description |
|-----|-------------|
| `ca` | Code action |
| `cr` | Code rename |
| `cf` | Code format |
| `cd` | Code definition |
| `cD` | Code declaration |
| `ci` | Code implementation |
| `ct` | Code type definition |
| `cR` | Code references |
| `cs` | Code symbols (document) |
| `cw` | Code workspace symbols |
| `ce` | Extract function (visual) |
| `cE` | Extract to file (visual) |
| `cv` | Extract variable (visual) |
| `cI` | Inline variable |
| `cb` | Extract block |
| `cB` | Block to file |
| `cq` | Refactor quick menu |
| `cd` | Duplicate line |
| `cx` | Delete (no register) |
| `cj` | Join lines |
| `co` | Open line below |
| `cO` | Open line above |
| `cs` | Substitute word |

## Git (`<leader>g`) - uses LazyGit

| Key | Description |
|-----|-------------|
| `gg` | **LazyGit** (main interface) |
| `gf` | LazyGit file history |
| `gl` | LazyGit log |
| `gs` | Stage hunk |
| `gr` | Reset hunk |
| `gS` | Stage buffer |
| `gu` | Undo stage |
| `gR` | Reset buffer |
| `gp` | Preview hunk |
| `gb` | Blame line |
| `gB` | Blame toggle |
| `gd` | Diff |
| `gD` | Diff HEAD |
| `gv` | View diff (diffview) |
| `gh` | History file |
| `gH` | History all |
| `gx` | Exit diffview |

## Jujutsu (`<leader>j`) - uses LazyJJ

| Key | Description |
|-----|-------------|
| `jj` | **LazyJJ** (main interface) |
| `js` | Status |
| `jd` | Diff |
| `jn` | New change |
| `jD` | Describe change |
| `jq` | Squash into parent |

## Run (`<leader>r`)

| Key | Description |
|-----|-------------|
| **Testing** |
| `rr` | Run test nearest |
| `rf` | Run file tests |
| `rd` | Debug test |
| `rS` | Stop test |
| `ra` | Attach test |
| `rw` | Output window |
| `rW` | Output panel |
| `rt` | Test summary |
| **Debug** |
| `rb` | Breakpoint toggle |
| `rB` | Breakpoint conditional |
| `rL` | Log point |
| `rc` | Continue debug |
| `rx` | Exit debug |
| `rR` | Restart debug |
| `rl` | Run last debug |
| `rC` | Run to cursor |
| `ri` | Step into |
| `ro` | Step over |
| `rO` | Step out |
| `ru` | Debug UI |
| `re` | Evaluate |
| `rp` | REPL |
| **Python** |
| `rv` | Venv select |
| `rV` | Venv cached |
| `rm` | Test method (Python) |
| `rk` | Test class (Python) |
| `rs` | Debug selection (visual) |

## Harpoon (`<leader>h`)

| Key | Description |
|-----|-------------|
| `ha` | Add file |
| `hh` | Harpoon menu |
| `hn` | Next file |
| `hp` | Previous file |
| `<leader>1-5` | Jump to file 1-5 |

## Toggle (`<leader>x`)

| Key | Description |
|-----|-------------|
| `xt` | Toggle theme |
| `xl` | Toggle lint |
| `xh` | Toggle inlay hints |
| `xw` | Toggle wrap |
| `xs` | Toggle spell |
| `xz` | Toggle zen mode |
| `xd` | Toggle dim (twilight) |
| `xp` | Toggle pencil |
| `xm` | Toggle markdown preview |

## Utils (`<leader>u`)

| Key | Description |
|-----|-------------|
| `un` | Notes |
| `uN` | Notes global |
| `uh` | HTTP run |
| `uH` | HTTP run all |
| `us` | HTTP scratchpad |
| `uj` | JSON viewer |
| `uc` | Case converter |
| `ud` | Text diff |
| `ut` | Token counter |
| `um` | Markdown preview |
| `ub` | Base64 convert |
| `uu` | URL encode |
| `uU` | UUID generate |
| `uT` | Timestamp |
| `up` | Color palette |
| `uJ` | JWT decode |
| `ur` | Regex generator |
| `uk` | Cron calculator |

## AI (`<leader>a`)

| Key | Description |
|-----|-------------|
| `aa` | Toggle AI assistant |
| `ac` | Toggle Claude |
| `ag` | Toggle Grok |
| `ap` | Ask prompt |

---

## Quick Access (No Leader Prefix)

| Key | Description |
|-----|-------------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `gc` | Comment toggle |
| `gb` | Comment block |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gy` | Go to type |
| `K` | Hover docs |
| `<C-\>` | Toggle terminal |
| `<C-h/j/k/l>` | Window navigation |
| `]c` / `[c` | Next/prev git hunk |
| `]d` / `[d` | Next/prev diagnostic |
| `]e` / `[e` | Next/prev error |
| `\\` | Neo-tree toggle |
| `<leader>y` | Yazi |
| `jk` / `kj` | Exit insert mode |

## Function Keys

| Key | Description |
|-----|-------------|
| `F5` | Debug continue |
| `F10` | Debug step over |
| `F11` | Debug step into |
| `F12` | Debug step out |

---

## Quick Reference

```
<leader>ff  → Find files
<leader>fg  → Find grep
<leader>ca  → Code action
<leader>cf  → Code format
<leader>rr  → Run test
<leader>rd  → Debug test
<leader>rb  → Breakpoint
<leader>gg  → LazyGit
<leader>jj  → LazyJJ
<leader>gs  → Stage hunk
<leader>xt  → Toggle theme
s           → Flash jump
gc          → Comment
<C-\>       → Terminal
```
