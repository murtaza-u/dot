#!/bin/sh

userresources="$HOME"/.config/x/Xresources
usermodmap="$HOME"/.config/x/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap" && xmodmap -e "clear lock"
fi

xset r rate 230 50
picom &
dunst &
sxhkd &
unclutter &
sbg -d
pulseaudio --start

lemonaid | \
    lemonbar -p -d \
    -f "JetBrains Mono Nerd Font:size=10:antialias=true:autohint=true:style=Medium" \
    -f "NotoColorEmoji:size=12:antialias=true:autohint=true" \
    -B "#1d2021" -F "#fbf1c7" &

exec devoid
