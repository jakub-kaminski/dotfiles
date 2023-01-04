#!/bin/bash

export teststr=$(xdotool getactivewindow getwindowname)

if [[ ${teststr} != *"nvim"* ]];then
    #xdotool key $1
    xdotool getactivewindow key $1
    #/home/jakub/.scripts/run_if_window_matches.sh --not --class "*nvim*" -- xdotool getactivewindow key {Down,Up}
else 
    xdotool getactivewindow key n
fi
