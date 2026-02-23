#!/bin/sh
xrandr --output eDP-1-1 --off --output HDMI-0 --off --output DP-2 --off --output DP-1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP-0 --off

i3-msg restart
# Reload the keyboard mappings (needed when a new typing device found)
bash ~/.config/i3/scripts/keyboard.sh
