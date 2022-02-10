HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
zstyle :compinstall filename "${HOME}/.config/zsh/.zshrc"

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

source ~/.config/base/cfg
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
