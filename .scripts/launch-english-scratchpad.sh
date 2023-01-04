#!/bin/bash
cd ~/hdd/Drive/@TODO
#xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T todo.txt -e nvim todo.txt -c "so Session.vim" -c Goyo
#xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T MY-ENGLISH -e nvim -u /home/jakub/.config/nvim/todo-init.vim english.md -c "so Session.vim"

xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T MY-ENGLISH -e nvim -u /home/jakub/.config/nvim/todo-init.vim
#xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T MY-ENGLISH -e nvim -u /home/jakub/.config/nvim/todo-init.vim -c "Obsession"

#xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T MY-ENGLISH -e nvim -c "so Session.vim"
# currently not using (because of the Tmux problems): -c Goyo
