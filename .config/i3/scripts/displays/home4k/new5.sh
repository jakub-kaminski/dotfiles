#!/bin/sh
xrandr --output VGA-0 --off --output LVDS-0 --off --output DP-5 --mode 3840x2160 --pos 0x0 --rotate normal --output DP-4 --off --output DP-3 --off --output DP-2 --off --output DP-1 --mode 1920x1200 --pos 3840x488 --rotate normal --output DP-0 --off
bash ~/.config/i3/scripts/displays/home4k/workspaces-to-output.sh

