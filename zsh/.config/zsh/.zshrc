source '/usr/share/zsh-antidote/antidote.zsh'
antidote load


bindkey -v

alias sudo='sudo '
alias ls='eza -l --icons=auto'
alias ll='eza -lha --icons=auto' # show long listing of all except ".."
alias l='eza -lh --icons=auto' # show long listing but no hidden dotfiles except "."
alias ld='eza -lhD --icons=auto'
#alias codejpy='code --enable-proposed-api ms-python.python'
alias bat="bat -n"
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gtvpn='openconnect --protocol=gp --user=zjacobson7 --passwd-on-stdin --server=vpn.gatech.edu'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
bindkey '^ ' autosuggest-accept

# argc-completions
# To add a subset of completions only, change next line e.g. argc_scripts=( cargo git )
argc_scripts=( $('ls' -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
source <(argc --argc-completions zsh $argc_scripts)

export EDITOR='nvim'


source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
