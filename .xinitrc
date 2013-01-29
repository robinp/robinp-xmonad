#!/bin/bash

xrdb -merge .Xresources

Esetroot -scale ~/Pictures/Background/hd-forest.jpg

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

netapplet --sm-disable &

xscreensaver -no-splash &

exec xmonad
