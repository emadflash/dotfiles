#!/usr/bin/env bash

declare -a pkg
pkg=("firefox" "pcmanfm" "ttf-inconsolata" "xmonad" "xmobar" "xarchiver" )
	
pkg_install() {
	for i in ${!pkg[@]}; do
		pacman --quiet --noconfirm -S ${pkg[$i]} 1>/dev/null || return 1
	done
}	
