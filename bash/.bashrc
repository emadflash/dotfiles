#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set nobeep
stty -ixon


# shopt
shopt -s autocd dirspell direxpand cdspell


# history
HISTSIZE= HISTFILESIZE=


# prompt
[ -f "/usr/share/git/completion/git-prompt.sh" -a -r "/usr/share/git/completion/git-prompt.sh" ] && . "/usr/share/git/completion/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
	prompt_color='\[\033[;94m\]'
	info_color='\[\033[1;31m\]'
	prompt_symbol=💀
    fi
    PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}('$info_color'\u${prompt_symbol}\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']$(__git_ps1)\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
    # BackTrack red prompt
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

## If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi


# keybindings
if [[ $- == *i* ]]
then
    bind '"\C-p": history-search-backward'
    bind '"\C-n": history-search-forward'
    bind "set completion-ignore-case on"
    bind "set show-all-if-ambiguous on"
fi

bind '"\t": menu-complete'
bind '"\e[Z": menu-complete-backward'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'


# enable completions
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion 
[[ -f "/usr/share/git/completion/git-completion.bash" ]] && source /usr/share/git/completion/git-completion.bash


# source aliases & functions
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions
