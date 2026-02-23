#!/bin/sh
xrandr --output LVDS-1 --primary --mode 1920x1080 --pos 3840x968 --rotate normal --output DP-3 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-2 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP-1 --off --output VGA-1 --off
bash ~/.config/i3/scripts/displays/home/workspaces-to-output.sh
