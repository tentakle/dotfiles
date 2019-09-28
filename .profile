#!/bin/bash

xset b off
xset -dpms
xset r rate 200 30
[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources
