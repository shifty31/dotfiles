ZSH_TMUX_DEFAULT_SESSION_NAME="default"
FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
FZF_DEFAULT_OPTS='--reverse --border'
FZF_ALT_C_COMMAND='fd --hidden --exclude .git'
FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Path adjustments
path+=(~/.local/bin/)
path+=(/opt/nvim)
path+=(~/.cargo/bin)

#zsh opts
setopt globdots

#zsh styling
zstyle ':completion:*' special-dirs false # removes the . and .. from completion
zstyle ':completion:*' completer _complete _ignored _files # adds file suggests last
