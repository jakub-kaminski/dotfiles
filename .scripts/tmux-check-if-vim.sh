#!/bin/bash
# credits: https://github.com/pypa/pipenv/issues/1407 user: RobbieClarken
pane_tty=$1
pipenv_pid=$(pgrep -t ${pane_tty/\/dev\/} pipenv)
if [[ $? == 0 ]]; then
  ps -o state=,comm= -p $(pstree -p $pipenv_pid | grep -Po '\(\d+\)' | tr -d '()')
else
  ps -o state=,comm= -t $pane_tty
fi | grep -qP '^[^TXZ] (view|vim)$'
