source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

bindkey -v

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias codejpy='code --enable-proposed-api ms-python.python'
alias bat="bat -n"
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gtvpn='sudo openconnect --protocol=gp --user=zjacobson7 --passwd-on-stdin --server=vpn.gatech.edu'


eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
