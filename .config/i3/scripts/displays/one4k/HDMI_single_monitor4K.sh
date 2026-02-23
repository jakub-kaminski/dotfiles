#!/bin/sh
xrandr --output DP-1 --off --output HDMI-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1 --off --output DP-2 --off

bash ~/.config/i3/scripts/displays/one4k/HDMI_workspaces-to-output.sh
