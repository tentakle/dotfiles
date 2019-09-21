#!/bin/bash

xset b off
xset -dpms
xset r rate 200 30
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
urxvtd -q -o -f &
