#!/bin/sh
xrandr --output LVDS-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-3 --off --output DP-2 --off --output DP-1 --off --output VGA-1 --off
bash ~/.config/i3/scripts/displays/laptop/workspaces-to-output.sh
