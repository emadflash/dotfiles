#!/usr/bin/sh

FZF_LOCAL_OPTS="--layout=reverse --height 55% --no-info"

# Get the display's resolution.
if type -fP xwininfo &> /dev/null; then
	getres(){ #: Two viable methods for fetching the display resolution.
		while read -a LINE; do
			if [ "${LINE[0]}" == '-geometry' ]; then
				printf "Your resolution is %s, according to xwininfo.\n" "${LINE[1]%+*+*}"
			fi
		done <<< "$(xwininfo -root)"
	}
elif type -fP xdpyinfo &> /dev/null; then
	getres(){ #: Two viable methods for fetching the display resolution.
		while read -a LINE; do
			if [ "${LINE[0]}" == 'dimensions:' ]; then
				printf "resolution - %s, according to xdpyinfo.\n" "${LINE[1]}"
			fi
		done <<< "$(xdpyinfo)"
	}
fi

if type -fP sensors &> /dev/null; then
	showfans(){ #: Show the available system fan speeds using sensors.
		while read; do
			if [[ $REPLY == *[Ff][Aa][Nn]*RPM ]]; then
				printf "%s\n" "$REPLY"
			fi
		done <<< "$(sensors)"
	}
fi

topmem(){ 
		awk "
			{
				M=\$1/1024
				if(NR<50 && M>1){
					printf(\"%'7dM %s\\n\", M, \$2)
				}
			}
		" <<< "$(\ps ax -o rss= -o comm= --sort -rss)"
	}


if type -fP fzf &> /dev/null ; then
	se() {
		  path=$(du -a ~/fun/ ~/.local/bin/ | awk '!/.git/ && !/venv/ {print $2}' | fzf ${FZF_LOCAL_OPTS} ) &&
		  $EDITOR "$path"
	}

	tsa() {
		  sess=$(tmux ls | fzf ${FZF_LOCAL_OPTS} | awk '{print $1}' | sed 's/://g') && tmux attach -t "$sess";
	}

	pi() {
		  pack=$(pacman --quiet -Ss | fzf ${FZF_LOCAL_OPTS} --prompt 'pkg-install : ' --preview 'pacman -Si {}' --preview-window=wrap --preview-window=hidden --no-info) &&
		  sudo pacman --noconfirm -S "$pack" &&
		  echo "installed: $pack ,  $(date)" >> "$XDG_CACHE_HOME"/pacman-hsts
	}

	pr() {
		  pack=$(pacman --quiet -Q | fzf ${FZF_LOCAL_OPTS} --prompt 'pkg-uninstall : ' --preview 'pacman -Qi {}' --preview-window=wrap --preview-window=hidden --no-info) && sudo pacman --noconfirm -Rns "$pack" &&
          echo "uninst   : $pack ,  $(date)" >> "$XDG_CACHE_HOME"/pacman-hsts
	}
fi
