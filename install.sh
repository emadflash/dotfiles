 #!/usr/bin/env bash

declare -a pkg
pkg=("firefox" "pcmanfm" "ttf-inconsolata" "xmonad" "xmobar" "xarchiver" )
	
declare -A link_map 
link_map['neovim']="$HOME/.config/nvim/"
link_map['bash']="$HOME/"
link_map['tmux']="$HOME/"
link_map['alacritty']="$HOME/.config/alacritty/"

pkg_install() {
	for i in ${!pkg[@]}; do
		pacman --quiet --noconfirm -S ${pkg[$i]} 1>/dev/null || return 1
	done
}	

symlink_it() {
	for _conf in *; do 
		if [[ ! -z "$_conf" ]] && [[ ${link_map["$_conf"]} ]]; then
			echo "$_conf" ${link_map["$_conf"]}
			#ln -s ./"$_conf" ${link_map["$key"]}
		fi
	done
}
