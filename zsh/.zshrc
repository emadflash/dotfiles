fpath=(~/.config/zsh/zsh "${fpath[@]}")
autoload -U compinit
autoload -Uk zsh_initialize_history
autoload -Uk zsh_initialize_bindkey
autoload -Uk zsh_initialize_menuselect
autoload -Uk zsh_initialize_ls_colors
autoload -Uk prompt_set_prefix
autoload -Uk prompt_set_cwd
autoload -Uk prompt_set_suffix

setopt autocd
setopt chase_dots
setopt prompt_subst
setopt interactive_comments

set -o emacs
compinit -d "$ZSH_CACHE/zcompdump"

zsh_initialize_history
zsh_initialize_bindkey
zsh_initialize_menuselect
zsh_initialize_ls_colors

# set prompt prefix
PROMPT="%B%F{green}$(prompt_set_prefix)%b"

# set prompt cwd
PROMPT="${PROMPT} %B%F{blue}$(prompt_set_cwd)%b"

# TODO(madflash): set prompt suffix
# PROMPT="${PROMPT} %B%F{red}$(prompt_set_suffix)%b"

# terminator
PROMPT="${PROMPT} %B$%b %F{grey}"

source "$HOME/.bash_aliases"
