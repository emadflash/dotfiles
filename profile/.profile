#
# ~/.profile
#

export PATH="$PATH:$HOME/.local/bin/:$HOME/.bin/"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export QT_QPA_PLATFORMTHEME=gtk2
export ZDOTDIR="$HOME/.config/zsh"
export LESSHISTFILE="/dev/null"
export MYSQL_HISTFILE="$XDG_CACHE_HOME/mysql_history"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
. "$HOME/.cargo/env"
