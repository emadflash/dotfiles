#
# ~/.profile
#

export PATH="$PATH:$HOME/.local/bin/:$HOME/.bin/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="/usr/bin/nvim"
export TERMINAL="/usr/local/bin/alacritty"
export BROWSER="/usr/bin/firefox"
export READER="/usr/bin/zathura"
export FILE="/usr/bin/vifm"
export VIDEO="/usr/bin/mpv"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export QT_QPA_PLATFORMTHEME=gtk2
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="$HOME/.config/zsh"
export LESSHISTFILE="/dev/null"
export MYSQL_HISTFILE="$XDG_CACHE_HOME/mysql_history"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

export FZF_DEFAULT_OPTS='
--color=16
--bind 'ctrl-t:toggle-preview'
'

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
