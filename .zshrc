# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Verasonics
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib"

plugins=(
  git
  docker
  brew
  vi-mode
  history-substring-search
  zsh-autosuggestions
  #history-search
  #
)

source $ZSH/oh-my-zsh.sh

#   _________________________
#   *** VARIABLES SECTION ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000


#   _______________________
#   *** ALIASES SECTION ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#   *** VPN ***
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse
alias pulse_start="bash /usr/local/pulse/pulseUi"

alias r="ranger"

alias jl='cd /home/jakub/Dropbox/Aplikacje/Overleaf/Thyroid_Journal'
#alias ambf="bash /usr/local/pulse/pulseUi"

# credits: https://stackoverflow.com/a/34340688/12070209

ambf_sim() {
    cd /home/jakub/ambf/bin/lin-x86_64
    ./ambf_simulator $1 $2 $3 $4 $5
}



#alias wpihours="/usr/bin/google-chrome www.wpi.edu/student-experience/sports-recreation/sports-recreation-center"

#   *** IDE, REPL ***
#alias clion_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/183.5429.37/bin/clion.sh"
#alias clion_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/192.6817.32/bin/clion.sh"
#alias clion_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/192.7142.39/bin/clion.sh"

#alias clion_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/213.6461.75/bin/clion.sh"

#alias clion_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/222.4345.21/bin/clion.sh"


#alias pycharm_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/193.5233.109/bin/pycharm.sh"
alias pycharm_start="bash /home/jakub/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/213.6461.77/bin/pycharm.sh"

alias matlab="/usr/local/MATLAB/R2021a/bin/matlab"
alias matlabt="/usr/local/MATLAB/R2021a/bin/matlab -nodesktop"
alias matlabt22="/home/jakub/matlab2022/bin/matlab -nodesktop"

export MESA_LOADER_DRIVER_OVERRIDE=i965

#alias matlabt="/usr/local/MATLAB/R2019a/bin/matlab -nodesktop -nosoftwareopengl"
#alias matlabt="/usr/local/MATLAB/R2018a/bin/matlab -nodesktop"
alias vmatlab="rlwrap -a /usr/local/MATLAB/R2019a/bin/matlab -nodesktop -nosplash" #TODO: not working now
alias mlint="/usr/local/MATLAB/R2019b/bin/glnxa64/mlint"
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libexpat.so


#alias python="python3"

# setting governors (power management)
alias __1high-power="sudo bash /home/jakub/Dropbox/sync/homedir/.config/i3/scripts/governors/performance.sh"
alias __1low-power="sudo bash /home/jakub/Dropbox/sync/homedir/.config/i3/scripts/governors/powersave.sh"


#   *** CUSTOM EDITOR CONFIGS ***
#alias nvim_coc="/home/jakub/tools/nvim/nvim -u /home/jakub/Dropbox/sync/homedir/.config/nvim/init-coc.vim"
# TODO: solving mlint dir issue


# Compiling Franka ROS Packages
alias franka_build="bash /home/jakub/Dropbox/sync/homedir/.work/alias_scripts/franka_build.sh; source devel/setup.sh"

# sourcing different ROS workspaces
alias whrl_ws="source ~/whrl_ws/devel/setup.zsh"
alias moveit_ws="source ~/ws_moveit/devel/setup.zsh"


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jakub/.zshrc'

autoload -Uz compinit
compinit

# set PATH so it includes user's private bin directories
# PATH="$HOME/bin:$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# my aliases
#alias rm="echo Use trash-put or /bin/rm"

# Start tmux by default
#tmux attach -t base || tmux new -s base

#export TERM="xterm-256color" #required for tmux TODO: consider uncommenting

# Credits: https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux
# If Tmux not running interactively, do not do anything
# credits: https://wiki.archlinux.org/index.php/tmux#Start_tmux_on_every_shell_login

# This messes with spacemacs
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec "tmux"

# This is NOT ok with spacemacs
#ZSH_TMUX_AUTOSTART=false
#[[ $TMUX == "" ]] && tmux new-session -A -s sesh

#[[ -z "$TMUX" ]] && exec "TERM=xterm-256color tmux"

# automatically start tmux session at login to enable incomieng ssh connection
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# prevent JetBrains terminal from starting with TMUX session
# https://stackoverflow.com/questions/36393178/prevent-tmux-from-starting-in-intellij-terminal
#if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm"]
#then
   #ZSH_TMUX_AUTOSTART=true
#fi

#source ~/.zsh_private-functions

#   ___________________________
#   *** KEYBINDINGS SECTION ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# use vi navigation keys
bindkey -v

# credits: http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/
# Repair broken completion
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search


export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim

# `v` is already mapped to visual mode, so we need to use a different key to
# open the current command text in Vim
#bindkey -M vicmd "^V" edit-command-line
bindkey -M vicmd v edit-command-line

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1


# This causes pasted URLs to be automatically quoted, without needing to disable globbing.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#export TERM=xterm-256color-italic

yanktoclipboard(){
        echo $BUFFER | xsel -i -b
    }
pastefromclipboard(){
        RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
    }
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard

#Trying to fix dbus accessibility
export NO_AT_BRIDGE=1

#   ________________________
#   *** ROBOTICS AND ROS ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#source /opt/ros/kinetic/setup.zsh
#source /opt/ros/melodic/setup.zsh
#source /opt/ros/noetic/setup.zsh

source /opt/ros/foxy/setup.zsh
source /home/jakub/ros2_ws/install/setup.zsh
#source /home/jakub/ros2_ws2_docker/install/setup.zsh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

#source /home/jakub/catkin_ws/devel/setup.zsh
#source ~/catkin_ws/devel/setup.zsh
#source ~/test_ws/devel/setup.zsh
#source ~/ros_workspace/devel/setup.zsh
#source ~/ambf/build/devel/setup.zsh

#export ROS_HOSTNAME=172.16.0.3
#export ROS_MASTER_URI=http://172.16.0.1:11311

# MoveIT tutorial
#source ~/ws_moveit/devel/setup.zsh


#source ~/whrl_ws/devel/setup.zsh
#source ~/kinetic_ws/devel/setup.zsh

#export JAVA_HOME=/usr/lib/jvm/java-8-oracle
#export IHMC_SOURCE_LOCATION=~/repository-group/ihmc-open-robotics-software

#source ~/ws_moveit/devel/setup.zsh

#source ~/ws_py/devel/setup.zsh
#source ~/tiago_public_ws/devel/setup.zsh

#KUKA
#export ROS_HOSTNAME=192.168.1.210
#export ROS_MASTER_URI=http://192.168.1.121:11311

#export ROS_HOSTNAME=192.168.1.121

#export ROS_HOSTNAME=192.168.1.200
#export ROS_MASTER_URI=http://192.168.1.121:11311

#Sensing
#export ROS_HOSTNAME=172.16.0.1
#export ROS_MASTER_URI=http://172.16.0.1:11311


#export ROS_HOSTNAME=192.168.1.5
#export ROS_MASTER_URI=http://192.168.1.5:11311


######## drcsim_docker ##############
#export NVIDIA_BIN="/usr/lib/nvidia-384/bin"
#export NVIDIA_LIB="/usr/lib/nvidia-384"
#export NVIDIA_LIB32="/usr/lib32/nvidia-384"

######### docker aliases #############
DUID=$((UID%256))
#export IP=${IPADDR:-172.16.$DUID.$DUID}
#alias source_dock="export ROS_MASTER_URI=http://${IP}:11311 && \
                  #export ROS_IP=172.16.$DUID.1" # Confirm this from ifconfig results

#export DRCSIM_DOCKER_DIR="~/drcsim_docker" # change this based on your configuration
#alias start_dock="cd $DRCSIM_DOCKER_DIR && bash runDrcsimDocker.sh"
#alias stop_dock="docker stop drcsim_${USER}"
#alias gazebo_dock="GAZEBO_MASTER_URI=http://${IP}:11345 vglrun gzclient"

#alias start_all="cd $DRCSIM_DOCKER_DIR && bash runDrcsimDocker.sh && GAZEBO_MASTER_URI=http://${IP}:11345 vglrun gzclient"

#alias perc=" rostopic pub /multisense/set_spindle_speed std_msgs/Float64 0.8 && sleep 3 && roslaunch tough_perception_bringup field_laser_assembler.launch"


# Conference


######### ROS  ##########
#source /opt/ros/kinetic/setup.zsh
#source ~/kinetic_ws/devel/setup.zsh
#source ~/kinetic_ws/install/share/drcsim/setup.sh

#source ~/kinetic_ws/install/setup.zsh
#source ~/kinetic_ws/install/share/drcsim/setup.sh


############ Tough ################
#export IHMC_SOURCE_LOCATION=~/repository-group/ihmc-open-robotics-software

#export JAVA_HOME=/usr/lib/jvm/java-8-oracle
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
#export IHMC_SOURCE_LOCATION=~/repository-group/ihmc-open-robotics-software


fpath=( ~/.zfunc "${fpath[@]}") # adding folder with zsh functions to the zsh function search path
autoload -U ~/.zfunc/mkcdir # it does not work now!



# Python virtualenv
#source /usr/local/bin/virtualenvwrapper.sh

#source_dock # this guy overlaps previous sources

#source ~/kinetic_ws/install/share/drcsim/setup.sh
#source ~/kinetic_ws/install/setup.zsh
#source ~/kinetic_ws/install/setup.sh
#source ~/kinetic_ws/devel/setup.sh
# make sure to do this every time you add a new package: # source devel/setup.zsh
    #
    #
    #


#   _______________________________
#   *** MACHINE LEARNING SECTION***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#export PATH="/home/jakub/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jakub/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

#export LD_PRELOAD=/lib/x86_64-linux-gnu/libpthread.so.0
#
#
#
#
#

#   _____________________
#   *** UNUSED SECTION***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# credit: user7089 https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
#if command -v tmux>/dev/null; then
      #[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
  #fi
  #

#   ________________________
#   *** ROBOTICS AND ROS ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#source /opt/ros/kinetic/setup.zsh
#source /opt/ros/melodic/setup.zsh
#source ~/catkin_ws/devel/setup.zsh
#source ~/test_ws/devel/setup.zsh
#source ~/ros_workspace/devel/setup.zsh
#source ~/ambf/build/devel/setup.zsh
