#!/bin/bash
SCREEN=$(xrandr | grep -m 1 -i " connected" | cut -f1 -d " ")
BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`

if [[ $(echo $BRIGHTNESS'>'0.1 | bc -l) == 1 ]]
then
    xrandr --output $SCREEN --brightness $(echo "$BRIGHTNESS - 0.1" | bc)
fi


