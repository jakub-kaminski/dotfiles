#!/bin/sh
#startx /usr/local/bin/i3

#xset s 10 # idle-state-seconds to save screen
xset dpms 0 0 15 # idle-state-seconds to turn off monitor

# initialize X resource database (if file ~/.Xresources is present on the system)
xrdb -load ~/.Xresources

exec i3

#exec i3 & wmpid=$!

#sleep 15
#/home/jakub/.scripts/launch-todo-scratchpad.sh

#wait $wmpid

