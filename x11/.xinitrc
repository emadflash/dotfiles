#!/bin/sh
setwall &
xrdb merge ~/.Xresources &
dunst &
nm-applet &
picom &
exec qtile
