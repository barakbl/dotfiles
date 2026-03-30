# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a "stow package" that mirrors the target directory structure (relative to `$HOME`):

```
dotfiles/
├── starship/
│   └── .config/
│       └── starship.toml
├── tmux/
│   └── .tmux.conf
├── zsh/
│   └── .config/
│       └── zsh/
│           └── zsh_custom
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
stow starship tmux zsh
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

| Package   | Contents                        |
|-----------|---------------------------------|
| `starship` | Starship shell prompt config   |
| `tmux`    | tmux configuration              |
| `zsh`     | Zsh configuration and customs   |

## Zsh Aliases & Functions

Defined in `zsh/.config/zsh/zsh_custom`:

| Alias/Function | Description |
|---|---|
| `ls`, `l`, `la`, `lla`, `lt` | `lsd` variants |
| `top` | `btop` |
| `c` | `clear` |
| `h` | `history` |
| `gs` | `git status` |
| `nvimf` | Open file picker with `fzf` in `nvim` |
| `t [name]` | Attach or create a tmux session (default: `main`) |
| `tmux2html` | Capture current tmux pane with colors as HTML and copy to clipboard |
| `coffee [time]` | Countdown timer with progress bar (e.g. `coffee 10m`, `coffee 30s`, default `5m`) |
| `weather [location]` | Show current weather (e.g. `weather London`, default: Tel Aviv) |
| `zmvlower` | Dry-run rename files to lowercase (recursive) |
| `zmvlower_run` | Rename files to lowercase (recursive) |
| `zmvnospaces` | Dry-run rename files replacing spaces with `-` |
| `zmvnospaces_run` | Rename files replacing spaces with `-` |

## tmux

Prefix remapped to `C-a`. Key bindings:

| Key | Action |
|---|---|
| `\|` | Split pane horizontally |
| `-` | Split pane vertically |
| `M-Arrow` | Navigate panes |
| `r` | Reload `~/.tmux.conf` |
