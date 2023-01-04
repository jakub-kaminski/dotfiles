#!/bin/bash
cd ~/hdd/Drive/@TODO
#xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T todo.txt -e nvim todo.txt -c "so Session.vim" -c Goyo
xterm -xrm 'XTerm.vt100.allowTitleOps: false' -T MY-TODOLIST -e nvim -u /home/jakub/.config/nvim/todo-init.vim todo.txt -c "so Session.vim"
# currently not using (because of the Tmux problems): -c Goyo
