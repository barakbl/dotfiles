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
│   └── .tmux.conf
├── zellij/
│   └── .config/
│       └── zellij/
│           └── config.kdl
├── zsh/
│   ├── .zshrc
│   └── .zsh_plugins.txt
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
git clone https://github.com/barakbl/dotfiles ~/dotfiles
cd ~/dotfiles
```

### 3. Stow packages

Symlink all packages at once:

```bash
stow ghostty nvim starship tmux zellij zsh
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
| `nvim`     | Neovim config (LazyVim + Catppuccin)  |
| `starship` | Starship shell prompt config          |
| `tmux`     | tmux configuration                    |
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
| `ze` | Attach to Zellij session `main` |
| `g` | `git` |
| `gp` | `git pull` |
| `gd` | `git diff` |
| `gba` | `git branch --all` |
| `gco` | `git checkout` |
| `gcm` | `git checkout <main-branch>` |
| `gpush` | `git push` |
| `gc` | `git commit --all --message` |
| `tmux2html` | Capture current tmux pane with colors as HTML and copy to clipboard |
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
- **nerdfetch** — system info displayed on shell startup
- **starship** — shell prompt

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

Prefix remapped to `C-a`. Key bindings:

| Key | Action |
|---|---|
| `\|` | Split pane horizontally |
| `-` | Split pane vertically |
| `M-Arrow` | Navigate panes |
| `r` | Reload `~/.tmux.conf` |
