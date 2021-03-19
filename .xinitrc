#!/bin/sh
xwallpaper --zoom "$HOME/.config/wall.png" &
xrdb merge ~/.Xresources &
dunst &
nm-applet &
exec xmonad
