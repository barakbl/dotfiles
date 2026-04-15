
# ─────────────────────────────────────────────
#  Environment
# ─────────────────────────────────────────────

music_svc='Music'  # swap to 'Spotify' if needed

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'

# ─────────────────────────────────────────────
#  Prompt & Shell Plugins
# ─────────────────────────────────────────────

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

#source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)


# ─────────────────────────────────────────────
#  Key Bindings
# ─────────────────────────────────────────────

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R'   fzf-history-widget

# ─────────────────────────────────────────────
#  zsh history
# ─────────────────────────────────────────────
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY


# ─────────────────────────────────────────────
#  FZF
# ─────────────────────────────────────────────

export FZF_COMPLETION_TRIGGER="**"
export FZF_CTRL_R_OPTS="--prompt 'History> ' --with-nth 2.."


# ─────────────────────────────────────────────
#  Aliases
# ─────────────────────────────────────────────

alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

alias top='btop'
alias c='clear'
alias h='history'
alias e='exit'

alias ze='zellij attach main'
alias nvimf='nvim $(fzf)'

alias g='git'
alias gp='git pull'
alias gd='git diff'
alias gba='git branch -all'
alias gco='git checkout'
alias gcm='git checkout $(git_main_branch)'
alias gpush='git push'
alias gc='git commit --all --message'

alias n='nvim'
alias vi=n

alias st='tmux source-file ~/.tmux.conf; echo "tmux reloaded"'
fp() { fd . "${1:-.}" --type f | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'; }

sql() { sqlite3 "$(ls -t "${1:-.}"/*.db 2>/dev/null | head -1)"; }

# created using scripts/print_glyphs.py script
alias glyphs="cat ~/.glyphs.txt | fzf --exact | grep -o '^.' | pbcopy"
# ─────────────────────────────────────────────
#  Functions
# ─────────────────────────────────────────────

t() { tmux new-session -A -s "${1:-main}" }

weather() { curl -s "wttr.in/${1:-TelAviv}?format=4" }

# Capture current tmux pane as HTML and copy to clipboard
tmux2html() {
  [[ -z "$TMUX" ]] && echo "Not in a tmux session" && return 1
  tmux capture-pane -p -e | ansifilter --html | pbcopy
  echo "Screen HTML copied to clipboard"
}

coffee() {
  local input="${1:-5m}" total
  case $input in
    *m) total=$(( ${input%m} * 60 )) ;;
    *s) total=${input%s} ;;
    *)  echo "Usage: coffee [<n>s|<n>m]  (e.g. 10s, 5m)" && return 1 ;;
  esac

  local i=$total
  while (( i > 0 )); do
    local mins=$(( i / 60 )) secs=$(( i % 60 ))
    local done_pct=$(( (total - i) * 20 / total )) bar=""
    for (( j=0; j<20; j++ )); do
      (( j < done_pct )) && bar+="█" || bar+="░"
    done
    printf "\r  ☕ [%s] %02d:%02d remaining " "$bar" "$mins" "$secs"
    sleep 1
    (( i-- ))
  done
  printf "\r  ☕ [████████████████████] Done! %-10s\n" ""
}

# ─────────────────────────────────────────────
#  yazi
# ─────────────────────────────────────────────

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# ─────────────────────────────────────────────
#  zmv Utilities  (bulk rename helpers)
# ─────────────────────────────────────────────

autoload zmv

zmvlower()       { zmv -Qvn '(**/)(*)(.D)' '$1${(L)2}' }
zmvlower_run()   { zmv -Qv  '(**/)(*)(.D)' '$1${(L)2}' }
zmvnospaces()    { zmv -n   '(**/)(* *)' '$1${2//( #-## #| ##)/-}' }
zmvnospaces_run(){ zmv      '(**/)(* *)' '$1${2//( #-## #| ##)/-}' }


# ─────────────────────────────────────────────
#  Python venv  (auto activate/deactivate)
# ─────────────────────────────────────────────

autoload -U add-zsh-hook

load-venv() {
  if [[ -d "venv" ]]; then
    [[ "$VIRTUAL_ENV" != "$PWD/venv" ]] && source venv/bin/activate && echo "🐍 Activated venv"
  elif [[ -d ".venv" ]]; then
    [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]] && source .venv/bin/activate && echo "🐍 Activated .venv"
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate && echo "🔒 Deactivated venv"
  fi
}

add-zsh-hook chpwd load-venv
load-venv


# ─────────────────────────────────────────────
#  macOS Only
# ─────────────────────────────────────────────

if [[ "$OSTYPE" == "darwin"* ]]; then
  mute()  { osascript -e 'set volume with output muted' }
  music() { osascript -e "tell application \"$music_svc\" to ${1:-playpause}" }
fi


# ─────────────────────────────────────────────
#  Starship extend (background cache refresh)
# ─────────────────────────────────────────────

_starship_extend_precmd() {
  [[ -f ~/.config/starship/extend.zsh ]] && zsh ~/.config/starship/extend.zsh &>/dev/null &!
}
add-zsh-hook precmd _starship_extend_precmd

# ─────────────────────────────────────────────
#  Local Overrides
# ─────────────────────────────────────────────

[[ -f ~/.zsh.local ]] && source ~/.zsh.local # .zsh_local -> not in git, personal stuff


# ─────────────────────────────────────────────
#  Greeting
# ─────────────────────────────────────────────

fastfetch

# bbsnip tab completion
source "/Users/barak/.config/bbsnip/bbsnip.plugin.zsh"

# OpenFang
export PATH=/Users/barak/.openfang/bin:$PATH
