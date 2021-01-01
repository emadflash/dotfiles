#
# ~/.profile
#
export PATH="$PATH:$HOME/.local/bin/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="/usr/bin/nvim"
export TERMINAL="/usr/local/bin/st"
export BROWSER="/usr/bin/firefox"
export READER="/usr/bin/zathura"
export FILE="/usr/bin/vifm"
export VIDEO="/usr/bin/mpv"
export WGETRC="$HOME/.config/wget/wgetrc"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export QT_QPA_PLATFORMTHEME=gtk2
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export SCRIPT_DIR="$HOME/.scripts"
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.config/password-store"
export LESSHISTFILE="/dev/null"
export MYSQL_HISTFILE="$XDG_CACHE_HOME/mysql_history"
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

export FZF_DEFAULT_OPTS='
--color=16
--bind 'ctrl-t:toggle-preview'
'

# tty 
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx