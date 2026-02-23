#!/bin/sh

#  +-----------+
#  |           |
#  |  LVDS-1   |
#  |           |
#  +-----------+

i3-msg restart

# Reload the keyboard mappings (needed when a new typing device found)
bash ~/.config/i3/scripts/keyboard.sh
