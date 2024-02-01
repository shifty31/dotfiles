ZSH_TMUX_DEFAULT_SESSION_NAME="default"
# FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --max-depth=1'
FZF_DEFAULT_OPTS='--reverse --border'
FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"


# Path adjustments
#
path+=(~/.local/bin/)
setopt globdots

zstyle ':completion:*' special-dirs false
zstyle ':completion:*' completer _complete _ignored _files
