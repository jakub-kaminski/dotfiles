# End of lines added by compinstall
export PATH='/bin:/sbin':"$PATH"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /opt/ros/kinetic/setup.bash
source ~/ws_py/devel/setup.bash

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon
export TERM=xterm-256color-italic

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jakub/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jakub/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jakub/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jakub/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

