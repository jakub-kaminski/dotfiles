# End of lines added by compinstall
alias bb="catkin build -j8 && source devel/setup.bash"
alias bd="catkin build --cmake-args -DCMAKE_BUILD_TYPE=Debug"
alias ff="./devel_scripts/start_robot_ui.py"
alias FF="./devel_scripts/start_robot_ui.py za2"
alias mqt="roslaunch rqt_launch rqt_launch.launch"

export PYTHONNOUSERSITE=False

#export PATH='/bin:/sbin':"$PATH"

## set PATH so it includes user's private bin directories
#PATH="$HOME/bin:$HOME/.local/bin:$PATH"
#export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#source /opt/ros/kinetic/setup.bash
#source ~/ws_py/devel/setup.bash

##so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
#stty -ixon
#export TERM=xterm-256color-italic

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
    #eval "$__conda_setup"
#else
    #if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        #. "$HOME/anaconda3/etc/profile.d/conda.sh"
    #else
        #export PATH="$HOME/anaconda3/bin:$PATH"
    #fi
#fi
#unset __conda_setup
## <<< conda initialize <<<


#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"
