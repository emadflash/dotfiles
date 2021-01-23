#!/bin/sh
setwall &
xrdb merge ~/.Xresources &
dunst &
nm-applet &
exec xmonad
