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
	se(){
		file=$(du -a ~/fun/ ~/.local/bin/ | awk '!/.git/ && !/venv/ {print $2}' | fzf) &&
		$EDITOR "$file"
	}

	ta(){
		sess=$(tmux ls | fzf | awk '{print $1}' | sed 's/://g') && tmux attach -t "$sess";
	}

	pi(){
		pkg=$(pacman --quiet -Ss | fzf --prompt 'pkg-install : ' --preview 'pacman -Si {}' --preview-window=wrap --preview-window=hidden --no-info) &&
		sudo pacman --noconfirm -S "$pkg"
	}

	pr(){
		pkg=$(pacman --quiet -Q | fzf --prompt 'pkg-uninstall : ' --preview 'pacman -Qi {}' --preview-window=wrap --preview-window=hidden --no-info) && sudo pacman --noconfirm -Rns "$pkg"
	}
fi
