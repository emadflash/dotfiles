 #!/usr/bin/env bash

declare -a pkg
pkg=("firefox" "pcmanfm" "ttf-inconsolata" "xmonad" "xmobar" "xarchiver" )
	
declare -A link_map 
link_map['nvim']="$HOME/.config/"
link_map['bash']="$HOME/"
link_map['tmux']="$HOME/"
link_map['alacritty']="$HOME/.config/"
link_map['zathura']="$HOME/.config/"
link_map['qtile']="$HOME/.config/"
link_map['xmonad']="$HOME/"
link_map['scripts']="$HOME/.local/bin/"
link_map['x11']="$HOME/"

pkg_install() {
	for i in ${!pkg[@]}; do
		pacman --quiet --noconfirm -S ${pkg[$i]} 1>/dev/null || return 1
	done
}	

symlink_it() {
	for _conf in *; do 
		if [[ ! -z "$_conf" ]] && [[ ${link_map["$_conf"]} ]]; then
			if [[ ${link_map["$_conf"]} == "$HOME/" ]] || [[ ${link_map["$_conf"]} == "$HOME/.local/bin/" ]]; then
				for i in $(find $_conf -maxdepth 1 -type f); do
					ln -sfv $(readlink -f "$i") ${link_map["$_conf"]}
				done
			else
				ln -sffv "$PWD/$_conf/" ${link_map["$_conf"]}
			fi
		fi
	done
}

symlink_it && echo "Finshed symlinking ..!"
