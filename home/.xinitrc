#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export EDITOR=vim &
export PAGER=less &
xsetroot -cursor_name left_ptr &
setxkbmap -option "ctrl:swapcaps" &

mpc pause &

devmon &
urxvtd &

#feh --bg-scale /home/jaye/.wallpaper &
chromium &

fix-dns

(conky | while read LINE; do xsetroot -name "$LINE"; done) &
exec dwm
