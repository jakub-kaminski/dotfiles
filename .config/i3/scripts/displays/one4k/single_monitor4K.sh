#!/bin/sh
xrandr --output DP-1 --off --output HDMI-1 --off --output eDP-1 --off --output DP-2 --mode 3840x2160 --pos 0x0 --rotate normal

bash ~/.config/i3/scripts/displays/one4k/workspaces-to-output.sh
