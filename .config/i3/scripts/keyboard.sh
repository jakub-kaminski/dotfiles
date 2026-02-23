#!/bin/bash
# Source: http://tiborsimko.org/capslock-escape-control.html

# Restore defaults
setxkbmap -option
# Kill xcape if already launched
kill $(ps aux | grep '[x]cape' | awk '{print $2}')

#
#ln -sf ~/Dropbox/sync/homedir/.profile ~/.profile
#ln -sf ~/Dropbox/sync/homedir/.Xmodmap ~/.Xmodmap

# Set Xmodmap special keys config
xmodmap /home/jakub/.Xmodmap

### MY KEYBOARD ###

#    * ,-------------------------------------------------------------.
#    * |Esc  |  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =|Backsp |
#    * |-------------------------------------------------------------|
#    * |Tab   |   Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|    \|
#    * |-------------------------------------------------------------|
#    * |Ctrl/Esc |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '|Return |
#    * |-------------------------------------------------------------|
#    * |Shift    |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /| Shift     |
#    * |-------------------------------------------------------------|
#    * |Ctrl|Gui |Alt |       Super/Space        |Alt |Gui |App |Ctrl|


# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps
# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'

#Todo: integrate SpaceFn: http://www.ljosa.com/~ljosa/software/spacefn-xorg/  https://github.com/ljosa/xf86-input-evdev-spacefn  https://cgit.freedesktop.org/xorg/driver/xf86-input-evdev

#   setxkbmap -option caps:escape


# Use pressed Return key (acting as Super_L) as a Modifier
# Return key is Return when released
#spare_modifier="Super_L"
#xmodmap -e "keycode 36 = $spare_modifier"
#xmodmap -e "add Super_L = $spare_modifier"
#xmodmap -e "keycode any = Return"
#xcape -e "$spare_modifier=Return"
# Edit your i3 config: set $mod mod4

# Use pressed Space key (acting as Super_L) as a Modifier
# Space key is Space when released

# Uncomment this paragraph to turn on dual space function
#spare_modifier="Super_L"
#xmodmap -e "keycode 65 = $spare_modifier"
#xmodmap -e "add Super_L = $spare_modifier"
#xmodmap -e "keycode any = space"
#xcape -e "$spare_modifier=space"

# Edit your i3 config: set $mod mod4

#spare_modifier="Super_L"
#xmodmap -e "keycode 47 = $spare_modifier"
#xmodmap -e "add Super_L = $spare_modifier"
#xmodmap -e "keycode any = semicolon"
#xcape -e "$spare_modifier=semicolon"
# Edit your i3 config: set $mod mod4


#ln -sf ~/Dropbox/sync/homedir/.profile_notinuse ~/.profile
#ln -sf ~/Dropbox/sync/homedir/.Xmodmap_notinuse ~/.Xmodmap
# Capsi3wm modifier
#ln -sf ~/Dropbox/sync/homedir/.profile_Caps ~/.profile
#ln -sf ~/Dropbox/sync/homedir/.Xmodmap_Caps ~/.Xmodmap

#xmodmap ~/.Xmodmap
#source ~/.Xmodmap

### MY KEYBOARD ###

#    * ,-------------------------------------------------------------.
#    * |Esc  |  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =|Backsp |
#    * |-------------------------------------------------------------|
#    * |Tab   |   Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|    \|
#    * |-------------------------------------------------------------|
#    * |Ctrl/Esc |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '|Return |
#    * |-------------------------------------------------------------|
#    * |Shift    |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /| Shift     |
#    * |-------------------------------------------------------------|
#    * |Ctrl|Gui |Alt |       Super/Space        |Alt |Gui |App |Ctrl|


### STANDARD KEYBOARD ###

#    * ,-----------------------------------------------------------.
#    * |Esc|  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =|Backsp |
#    * |-----------------------------------------------------------|
#    * |Tab  |  Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|    \|
#    * |-----------------------------------------------------------|
#    * |Caps  |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '|Return  |
#    * |-----------------------------------------------------------|
#    * |Shift   |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /|Shift     |
#    * |-----------------------------------------------------------|
#    * |Ctrl|Gui |Alt |      Space             |Alt |Gui |App |Ctrl|
