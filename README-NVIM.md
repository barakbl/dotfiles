# Neovim Cheatsheet

LazyVim-based config with Python LSP (pyright + ruff).

> `<leader>` = **Space**

---

## LSP — Python (pyright)

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gy` | Go to type definition |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<C-o>` | Jump back |
| `<C-i>` | Jump forward |

### Information
| Key | Action |
|-----|--------|
| `K` | Hover docs / type signature |
| `<C-k>` | Signature help (while typing args) |

### Editing
| Key | Action |
|-----|--------|
| `<leader>cr` | Rename symbol (project-wide) |
| `<leader>ca` | Code actions (fix imports, etc.) |
| `<leader>cf` | Format file (ruff) |
| `<leader>cA` | Source code actions |

### Diagnostics
| Key | Action |
|-----|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `]e` | Next error |
| `[e` | Previous error |
| `]w` | Next warning |
| `[w` | Previous warning |
| `<leader>cd` | Line diagnostics (float) |
| `<leader>xx` | Trouble: all diagnostics |
| `<leader>xX` | Trouble: buffer diagnostics |

---

## File Navigation

| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Buffers |
| `<leader>e` | File explorer (neo-tree) |
| `<leader>E` | File explorer (floating) |

---

## Buffers & Windows

| Key | Action |
|-----|--------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Delete buffer + window |
| `<C-h/j/k/l>` | Navigate windows |
| `<leader>wv` | Split vertical |
| `<leader>ws` | Split horizontal |
| `<leader>wd` | Delete window |

---

## Code & Search

| Key | Action |
|-----|--------|
| `<leader>/` | Grep in current buffer |
| `<leader>ss` | Search symbols (LSP) |
| `<leader>sS` | Search workspace symbols |
| `<leader>sd` | Search diagnostics |
| `gcc` | Toggle line comment |
| `gc` + motion | Toggle comment |

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Lazygit |
| `<leader>gb` | Git blame line |
| `<leader>gd` | Git diff |
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |

---

## UI Toggles

| Key | Action |
|-----|--------|
| `<leader>uf` | Toggle auto-format |
| `<leader>us` | Toggle spelling |
| `<leader>uw` | Toggle word wrap |
| `<leader>ul` | Toggle line numbers |
| `<leader>ud` | Toggle diagnostics |
| `<leader>uc` | Toggle conceal |

---

## Custom Keymaps

| Key | Action |
|-----|--------|
| `<leader>rp` | Run current Python file in a terminal split |

---

## Tmux

> `M` = **Alt**

### Pane Navigation
| Key | Action |
|-----|--------|
| `M-Left` / `M-h` | Move to left pane |
| `M-Right` / `M-l` | Move to right pane |
| `M-Up` / `M-k` | Move to pane above |
| `M-Down` / `M-m` | Move to pane below |

### Pane Splitting
| Key | Action |
|-----|--------|
| `M-r` | Split pane horizontally |
| `M-d` | Split pane vertically |

### Aliases
| Alias | Action |
|-------|--------|
| `st` | Reload tmux config (`tmux source-file ~/.tmux.conf`) |

---

## Useful Commands

```
:Mason          install/manage LSP servers, linters, formatters
:LspInfo        show active LSP clients for current buffer
:Lazy           manage plugins (update, install, profile)
:LazyHealth     check config health
:checkhealth    overall Neovim health
```
