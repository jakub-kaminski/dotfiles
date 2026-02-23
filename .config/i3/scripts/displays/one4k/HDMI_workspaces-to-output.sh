#!/bin/sh
# to be finished
#  +---------------+ 
#  |               | 
#  |    HDMI-1     |   
#  |               |  
#  |               | 
#  +---------------+  
#                                
#                                
#                                

#i3-msg "[workspace=2] move workspace to output DP-2"
# Chrome
i3-msg "[workspace=2] move workspace to output HDMI-1"
# Opera
i3-msg "[workspace=3] move workspace to output HDMI-1"
# VIM 
#i3-msg "[workspace=2] move workspace to output DP-5"

# IDE
i3-msg "[workspace=1] move workspace to output HDMI-1"
# Command Line tools
i3-msg "[workspace=4] move workspace to output HDMI-1"
i3-msg "[workspace=5] move workspace to output HDMI-1"
i3-msg "[workspace=10] move workspace to output HDMI-1"

i3-msg restart

# Reload the keyboard mappings (needed when a new typing device found)
bash ~/.config/i3/scripts/keyboard.sh
