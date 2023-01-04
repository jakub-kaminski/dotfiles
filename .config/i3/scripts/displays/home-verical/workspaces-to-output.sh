#!/bin/sh
#  +---------+
#  |         | +------------+
#  |         | |            |
#  |  DP-3   | |    DP-2    |  
#  |         | |            | 
#  |         | +------------+ 
#  |         |                  
#  +---------+
#                                

# Chrome
i3-msg "[workspace=2] move workspace to output DP-2"
# Opera
i3-msg "[workspace=3] move workspace to output DP-2"
# VIM 
#i3-msg "[workspace=2] move workspace to output DP-2"

# IDE
i3-msg "[workspace=1] move workspace to output DP-3"
# Command Line tools
i3-msg "[workspace=4] move workspace to output DP-3"
i3-msg "[workspace=10] move workspace to output DP-2"

i3-msg restart

# Reload the keyboard mappings (needed when a new typing device found)
bash ~/.config/i3/scripts/keyboard.sh
