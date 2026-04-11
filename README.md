# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a "stow package" that mirrors the target directory structure (relative to `$HOME`):

```
dotfiles/
├── ghostty/
│   └── .config/
│       └── ghostty/
│           └── config
├── kitty/
│   └── .config/
│       └── kitty/
│           └── kitty.conf
├── nvim/
│   └── .config/
│       └── nvim/
│           ├── init.lua
│           └── lua/
│               ├── config/
│               └── plugins/
├── starship/
│   └── .config/
│       └── starship.toml
├── tmux/
│   ├── .tmux.conf
│   ├── .tmux-cheatsheet
│   └── .config/
│       └── tmux/
│           └── plugins/
│               └── catppuccin/
│                   └── tmux/  ← git submodule
├── zellij/
│   └── .config/
│       └── zellij/
│           └── config.kdl
├── zsh/
│   ├── .zshrc
│   ├── .glyphs.txt
│   └── .zsh_plugins.txt
├── scripts/
│   └── print_glyphs.py
└── setup-mac.sh
```

When you stow a package, its contents are symlinked into `$HOME` preserving the directory structure. For example, stowing `starship` creates `~/.config/starship.toml -> ~/dotfiles/starship/.config/starship.toml`.

## Setup on a New Machine

### 1. Install dependencies

```bash
./setup-mac.sh
```

This installs Homebrew packages including `stow`, `zsh`, `starship`, and other tools.

### 2. Clone the repo

```bash
git clone --recurse-submodules https://github.com/barakbl/dotfiles ~/dotfiles
cd ~/dotfiles
```

### 3. Stow packages

Symlink all packages at once:

```bash
stow ghostty kitty nvim starship tmux zellij zsh
```

Or stow a single package:

```bash
stow starship
```

## Managing Dotfiles

### Add a new dotfile

1. Move the file into the appropriate package directory, mirroring its path under `$HOME`:
   ```bash
   mkdir -p ~/dotfiles/zsh/.config/zsh
   mv ~/.config/zsh/aliases ~/dotfiles/zsh/.config/zsh/aliases
   ```
2. Stow the package to create the symlink:
   ```bash
   stow zsh
   ```

### Remove symlinks

```bash
stow -D starship
```

### Re-stow (update symlinks after changes)

```bash
stow -R starship
```

### Dry run (preview without making changes)

```bash
stow -n -v starship
```

## Packages

| Package    | Contents                              |
|------------|---------------------------------------|
| `ghostty`  | Ghostty terminal config (Catppuccin)  |
| `kitty`    | Kitty terminal config                 |
| `nvim`     | Neovim config (LazyVim + Catppuccin)  |
| `starship` | Starship shell prompt config          |
| `tmux`     | tmux config + Catppuccin plugin (submodule) |
| `zellij`   | Zellij terminal multiplexer config    |
| `zsh`      | Zsh configuration, aliases & plugins  |

## Zsh

### Plugin management

Plugins are managed with [antidote](https://getantidote.github.io/). Edit `zsh/.zsh_plugins.txt` to add or remove plugins. Current plugins:

- `fast-syntax-highlighting` — syntax highlighting (deferred)
- `zsh-completions` — additional completions
- `zephyr` — completion, macOS, and history plugin modules
- `zsh-autosuggestions` — fish-like suggestions as you type
- `zsh-history-substring-search` — up/down arrow history search

### Local config

Machine-specific config can be placed in `~/.zsh.local` (gitignored via `*.local`). It is sourced at the end of `.zshrc`.

### Aliases & Functions

Defined in `zsh/.zshrc`:

| Alias/Function | Description |
|---|---|
| `ls`, `l`, `la`, `lla`, `lt` | `lsd` variants |
| `top` | `btop` |
| `c` | `clear` |
| `h` | `history` |
| `n`, `vi` | `nvim` |
| `nvimf` | Open file picker with `fzf` in `nvim` |
| `fp [dir]` | Fuzzy-find a file in `dir` (default: `.`) and preview with `bat` |
| `sql [dir]` | Open the latest `.db` file in `dir` (default: `.`) with `sqlite3` |
| `ze` | Attach to Zellij session `main` |
| `g` | `git` |
| `gp` | `git pull` |
| `gd` | `git diff` |
| `gba` | `git branch --all` |
| `gco` | `git checkout` |
| `gcm` | `git checkout <main-branch>` |
| `gpush` | `git push` |
| `gc` | `git commit --all --message` |
| `glyphs` | Pick a Nerd Font glyph with `fzf` and copy it to clipboard |
| `tmux2html` | Capture current tmux pane with colors as HTML and copy to clipboard |
| `y [args]` | Yazi file manager wrapper — `cd`s to the directory yazi exits into |
| `t [name]` | Attach to (or create) a tmux session named `name` (default: `main`) |
| `coffee [time]` | Countdown timer with progress bar (e.g. `coffee 10m`, `coffee 30s`, default `5m`) |
| `weather [location]` | Show current weather (e.g. `weather London`, default: Tel Aviv) |
| `mute` | Mute system volume (macOS only) |
| `music [action]` | Control music app (macOS only, default action: `playpause`) |
| `zmvlower` | Dry-run rename files to lowercase (recursive) |
| `zmvlower_run` | Rename files to lowercase (recursive) |
| `zmvnospaces` | Dry-run rename files replacing spaces with `-` |
| `zmvnospaces_run` | Rename files replacing spaces with `-` |
| `load-venv` | Auto-activate/deactivate Python venv on `cd` |

### music

The `music` function controls whichever app is set in `music_svc` (top of `.zshrc`):

```zsh
music_svc='Music'   # or 'Spotify'
```

| Command | Action |
|---|---|
| `music` | Toggle play/pause |
| `music playpause` | Toggle play/pause |
| `music next track` | Skip to next track |
| `music previous track` | Go to previous track |
| `music stop` | Stop playback |

### Integrations

- **zoxide** — smarter `cd` (loaded via `eval "$(zoxide init zsh)"`)
- **fzf** — fuzzy finder for files and history (`Ctrl-R`, `**` completion trigger)
- **fastfetch** — system info displayed on shell startup
- **starship** — shell prompt

## Starship

Shell prompt powered by [Starship](https://starship.rs/).

| Setting | Value |
|---|---|
| Newline between prompts | yes |
| Success symbol | `>` (bold green) |
| Package module | disabled |
| Lua module | disabled (avoids false trigger from `~/init.lua` nvim symlink) |

### Git status

Minimal — only shows what matters:

| Symbol | Meaning |
|---|---|
| `~` | Modified files |
| `⇡` | Ahead of remote |
| `⇣` | Behind remote |
| `⇕` | Diverged |
| *(nothing)* | Clean |

## Ghostty

Ghostty terminal with Catppuccin Mocha theme.

### Keybindings

| Binding | Sends | Purpose |
|---|---|---|
| `Alt+Left` | `\x1b[1;3D` | Word-left / pane nav in apps |
| `Alt+Right` | `\x1b[1;3C` | Word-right / pane nav in apps |
| `Alt+Up` | `\x1b[1;3A` | Pane nav up |
| `Alt+Down` | `\x1b[1;3B` | Pane nav down |

`macos-option-as-alt = left` — the left Option key is treated as Alt, enabling these bindings.

## Kitty

Kitty terminal with `macos_option_as_alt yes` — the Option key acts as Alt, enabling Alt-based keybindings in terminal apps (e.g. tmux pane navigation, word-jump in editors).

## Scripts

Utility scripts in `scripts/` (not stow packages):

| Script | Description |
|---|---|
| `print_glyphs.py` | Fetches Nerd Font glyph names from the upstream repo and prints all glyphs with codepoints and names to stdout. Used to generate `~/.glyphs.txt` for the `glyphs` alias. |

To regenerate the glyphs file:
```bash
python3 scripts/print_glyphs.py > ~/.glyphs.txt
```

## Neovim

Built on [LazyVim](https://www.lazyvim.org/) with Catppuccin colorscheme.

| Path | Purpose |
|---|---|
| `init.lua` | Entry point |
| `lua/config/` | Options, keymaps, autocmds |
| `lua/plugins/` | Plugin overrides (colorscheme, etc.) |

## Zellij

Terminal multiplexer with Catppuccin Macchiato theme, vim-style keybinds (`clear-defaults=true`), and tmux compatibility mode (`Ctrl-b` prefix).

| Mode | Key | Action |
|---|---|---|
| **Pane** (`Ctrl-p`) | `h/j/k/l` | Navigate panes |
| | `n` | New pane |
| | `d` / `r` | Split down / right |
| | `f` | Fullscreen toggle |
| | `x` | Close pane |
| **Tab** (`Ctrl-t`) | `n` | New tab |
| | `1-9` | Go to tab N |
| | `r` | Rename tab |
| | `x` | Close tab |
| **Resize** (`Ctrl-n`) | `h/j/k/l` | Increase size |
| | `H/J/K/L` | Decrease size |
| **Scroll** (`Ctrl-s`) | `j/k` | Scroll down/up |
| | `d/u` | Half-page down/up |
| | `s` | Enter search |
| **Session** (`Ctrl-o`) | `w` | Session manager |
| | `d` | Detach |
| **tmux** (`Ctrl-b`) | `"` / `%` | Split down / right |
| | `c` | New tab |
| | `n/p` | Next/previous tab |
| **Global** | `Alt h/j/k/l` | Navigate panes/tabs |
| | `Alt n` | New pane |
| | `Ctrl-g` | Lock mode |

## tmux

Prefix remapped to `C-a`. Pane navigation and splitting use `Alt` (`M`) directly — **no prefix needed**.

Theme: [Catppuccin Mocha](https://github.com/catppuccin/tmux) — installed as a git submodule at `tmux/.config/tmux/plugins/catppuccin/tmux/`. A cheatsheet is available at `~/.tmux-cheatsheet`.


### Pane Navigation
| Key | Action |
|---|---|
| `M-Left` / `M-h` | Move to left pane |
| `M-Right` / `M-l` | Move to right pane |
| `M-Up` / `M-k` | Move to pane above |
| `M-Down` / `M-m` | Move to pane below |

### Pane Splitting
| Key | Action |
|---|---|
| `M-r` | Split pane horizontally |
| `M-d` | Split pane vertically |

### Pane Resize
| Key | Action |
|---|---|
| `prefix + H` | Resize left 5 cells |
| `prefix + J` | Resize down 5 cells |
| `prefix + K` | Resize up 5 cells |
| `prefix + L` | Resize right 5 cells |

### Close Pane
| Key | Action |
|---|---|
| `M-q` | Kill current pane |

### Windows / Tabs
| Key | Action |
|---|---|
| `M-t` | New window |
| `M-,` | Rename window |
| `M-1` … `M-9` | Select window by number |

### Other Bindings
| Key | Action |
|---|---|
| `prefix + r` | Reload `~/.tmux.conf` |

### Inactive pane dimming

Inactive panes use a slightly darker background (`colour236`) while the active pane uses `colour235`, giving a subtle visual focus indicator.

### Aliases
| Alias | Action |
|---|---|
| `st` | Reload tmux config (`tmux source-file ~/.tmux.conf`) |
