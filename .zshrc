# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zachj/.zshrc'

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias codejpy='code --enable-proposed-api ms-python.python'
alias update='sudo pacman -Syu && yay -Sua'

source ~/.zshplugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# End of lines added by compinstall
. "$HOME/.cargo/env"

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
eval "$(starship init zsh)"
