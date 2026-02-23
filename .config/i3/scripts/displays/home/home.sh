#!/bin/sh
xrandr --output VGA-0 --off --output LVDS-0 --off --output DP-5 --off --output DP-4 --off --output DP-3 --off --output DP-2 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP-0 --off
bash ~/.config/i3/scripts/displays/home/workspaces-to-output.sh
