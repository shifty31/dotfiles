
# alias ls='eza --grid --long --header --icons --all --group-directories-first --no-permissions --no-user --sort=name --modified --time-style=iso'
alias ls='eza  --icons -F -H --git --sort Name  --all  --group-directories-first'
alias py='python3'
alias rmi='rm -rfi'
alias nv='nvim'

alias nconf='nvim ~/.config/'

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lconf='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
