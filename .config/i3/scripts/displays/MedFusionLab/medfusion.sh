#!/bin/sh
xrandr --output HDMI-1 --mode 1920x1200 --pos 3840x456 --rotate normal --output eDP-1 --off --output DP-2 --primary --mode 3840x2160 --pos 0x0 --rotate normal

#xrandr --output DP-1 --off --output HDMI-1 --mode 1920x1200 --pos 3840x456 --rotate normal --output eDP-1 --off --output DP-2 --primary --mode 3840x2160 --pos 0x0 --rotate normal
bash ~/.config/i3/scripts/displays/MedFusionLab/workspaces-to-output.sh
