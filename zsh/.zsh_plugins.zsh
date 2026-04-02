fpath+=( "$HOME/Library/Caches/antidote/github.com/jeffreytse/zsh-vi-mode" )
source "$HOME/Library/Caches/antidote/github.com/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
if ! (( $+functions[zsh-defer] )); then
  fpath+=( "$HOME/Library/Caches/antidote/github.com/romkatv/zsh-defer" )
  source "$HOME/Library/Caches/antidote/github.com/romkatv/zsh-defer/zsh-defer.plugin.zsh"
fi
fpath+=( "$HOME/Library/Caches/antidote/github.com/zdharma-continuum/fast-syntax-highlighting" )
zsh-defer source "$HOME/Library/Caches/antidote/github.com/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
