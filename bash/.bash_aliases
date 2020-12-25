#!/usr/bin/sh
alias vi='vim'
alias iv='vim'
alias ci='vim'
alias rc="vim ~/.bashrc"
alias r="source ~/.bashrc"
alias rm="rm -iv"
alias mv="mv -iv"
alias grep="grep --color=auto"
alias df="df -h"

#ls common alias
alias \
	sl="ls" \
 	ls='ls --color=auto --group-directories-first' \
 	l='ls -lAFh'  \
 	la='ls -lFh' \
 	lr='ls -tRFh' \
 	lt='ls -ltFh' \
 	ll='ls -l' \
 	ldot='ls -ld .*' \
 	lS='ls -1FSsh' \
 	lart='ls -1Fcart' \
 	lrt='ls -1Fcrt'

#config files
alias \
	vrc="vim ~/.vimrc" \
	xrc="vim ~/.xmonad/xmonad.hs"

alias tsm="transmission-remote -l"

alias cd..="cd .."
alias csb="cd /mnt/usb"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias \
	IP='curl https://ifconfig.co'  \
 	rss="grep 'https\|http'  ~/.config/newsboat/urls | sed -E 's/\"*\"//g' | sed -E 's/\"*//g'" \
 	disk="df -h | sed -n '4'p"

#pacman 
alias \
	pac="sudo pacman" \
	calcurse="calcurse -C ~/.config/calcurse -D ~/.config/calcurse" \
	tmux="tmux -f ~/.config/tmux/tmux.conf"

alias yt="youtube-dl"
alias ytm="youtube-dl --extract-audio --audio-format mp3"


#date commands
alias daysleft='echo "There are $(($(date +%j -d"Dec 31, $(date +%Y)")-$(date +%j))) left in year $(date +%Y)."'
alias weeknum='date +%V'
alias cal='task calendar'



# git
alias \
	gs="git status"
	gl="git log"
	gll="git log --all"
	gb="git branch"
	gc="git checkout"
