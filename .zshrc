#   ******************************************************************
#   *** OPTIMIZATION: Start tmux FIRST, before any heavy loading ***
#   ******************************************************************
# This MUST be at the top to avoid loading oh-my-zsh twice!
# When opening a new terminal, we exec tmux immediately before
# doing any expensive initialization.

# Only for interactive shells
if [[ $- == *i* ]]; then
  # If not already in tmux, exec into tmux immediately
  # (set NO_TMUX=1 in the environment to opt out, e.g. detached xterms)
  if [[ -z "$TMUX" && -z "$NO_TMUX" ]]; then
    # For SSH connections, use a dedicated session
    if [[ -n "$SSH_CONNECTION" ]]; then
      exec tmux new-session -A -s ssh_tmux
    else
      # For local terminals, just exec tmux
      exec tmux
    fi
  fi
fi

# --- Everything below only runs INSIDE tmux ---

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export QTDIR=$HOME/Qt/6.4.3

# fix VLC problems
# Disabled 2026-05-27: this forces all GL clients into software rendering,
# which breaks any Qt/GL application (e.g. tool-load-simulator GUI).
# If VLC still has the original problem, prefer fixing VLC instead.
# export LIBGL_ALWAYS_SOFTWARE=1

ZSH_THEME="robbyrussell"

# Skip compaudit security scan of completion dirs (~75ms, single-user machine)
ZSH_DISABLE_COMPFIX=true

# Verasonics
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib"

plugins=(
  git
  docker
  brew
  vi-mode
  history-substring-search
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

alias cost="npx ccusage@latest daily"
# codex installed globally via nvm (npm install -g @openai/codex)
alias wr="source $HOME/.scripts/daydir"

alias killros2="killall -9 \
  ros2 \
  _ros2_daemon \
  rviz2 \
  gzserver \
  robot_state_publisher \
  gzclient controller_server \
  lifecycle_manager"

alias wbts="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia webots"
alias wbts2024a="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia webots2024a"

alias r="ranger"
alias q="exit"
alias wd='wrapper-dev.sh'
alias wda='wrapper-dev-attach.sh'
alias gw='git-worktree.sh'
alias gwr='git-worktree-from-remote.sh'
alias gr='cd "$(git rev-parse --show-toplevel)"'

#   *** IDE, REPL ***
alias clion_start="bash $HOME/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/231.8109.174/bin/clion.sh"
alias pycharm_start="bash $HOME/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/213.6461.77/bin/pycharm.sh"

alias matlab="/usr/local/MATLAB/R2023a/bin/matlab"
alias matlabt="/usr/local/MATLAB/R2023a/bin/matlab -nodesktop"
alias matlabt22="$HOME/matlab2022/bin/matlab -nodesktop"

# Disabled 2026-05-27: this forces Mesa to load the Intel i965 driver, but
# this machine is NVIDIA-only (GeForce GTX 1070). Forcing i965 makes Mesa
# fail driver load and prevents *any* GL context creation, even via NVIDIA.
# export MESA_LOADER_DRIVER_OVERRIDE=i965

alias mlint="/usr/local/MATLAB/R2019b/bin/glnxa64/mlint"
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libexpat.so

#   ____________________
#   *** SHELL SETUP ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

zstyle :compinstall filename "$HOME/.zshrc"

# compinit is handled by oh-my-zsh (cached ~/.zcompdump-<host>-<ver> + zwc).
# Do NOT call compinit again here — a second call re-scanned all ~1000
# completion files and rewrote the dump on every startup (~0.6s).

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Disable Ctrl-S/Ctrl-Q flow control
stty -ixon

#   ___________________________
#   *** KEYBINDINGS SECTION ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

bindkey -v

# Fix arrow keys in vi mode
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search

export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim

# Open current command in vim with 'v' in normal mode
bindkey -M vicmd v edit-command-line

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Auto-quote pasted URLs
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Vi-mode clipboard integration — route through the unified clip bridge
# (~/.scripts/clip-copy / clip-paste) so shell yanks sync with tmux/vim/nvim and
# work over ssh (OSC 52) just like locally. Handy general helpers:
#   echo hi | clip      copy stdin        clipo      print the clipboard
alias clip='clip-copy'
alias clipo='clip-paste'
yanktoclipboard(){
        print -rn -- "$BUFFER" | clip-copy
    }
pastefromclipboard(){
        RBUFFER="$(clip-paste </dev/null)$RBUFFER"
    }
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard

export NO_AT_BRIDGE=1

#   ________________________
#   *** ROBOTICS AND ROS ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#   *** Lazy-load ROS (saves ~0.4s) ***
# ROS is loaded on-demand when you first run ros2/rviz2/colcon/rosdep etc.
# Or manually with 'rossetup' command
export ROS_IP=127.0.0.1
export ROS_MASTER_URI=http://127.0.0.1:11311

_ros_loaded=0
_ros_load() {
  if [[ $_ros_loaded -eq 0 ]]; then
    _ros_loaded=1
    unset -f ros2 rviz2 colcon rosdep roslaunch rosrun rqt rqt_graph rossetup
    source /opt/ros/humble/setup.zsh
    # Hook for additional workspaces defined in .zshrc-private
    if typeset -f _ros_load_workspaces > /dev/null; then
      _ros_load_workspaces
    fi
    echo "ROS Humble environment loaded."
  fi
}

rossetup() { _ros_load; }
ros2()     { _ros_load; command ros2 "$@"; }
rviz2()    { _ros_load; command rviz2 "$@"; }
colcon()   { _ros_load; command colcon "$@"; }
rosdep()   { _ros_load; command rosdep "$@"; }
roslaunch(){ _ros_load; command roslaunch "$@"; }
rosrun()   { _ros_load; command rosrun "$@"; }
rqt()      { _ros_load; command rqt "$@"; }
rqt_graph(){ _ros_load; command rqt_graph "$@"; }

fpath=( ~/.zfunc "${fpath[@]}")

#   _______________________________
#   *** MACHINE LEARNING SECTION ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#   *** Lazy-load conda (saves ~0.2-0.3s) ***
conda() {
  unset -f conda
  __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  conda "$@"
}

#   _________________________
#   *** NODE / JS TOOLING ***
#   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

#   *** Lazy-load NVM (saves ~0.25s) ***
export NVM_DIR="$HOME/.nvm"

_nvm_load() {
  unset -f nvm node npm npx yarn pnpm codex
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm()  { _nvm_load; nvm "$@"; }
node() { _nvm_load; node "$@"; }
npm()  { _nvm_load; npm "$@"; }
npx()  { _nvm_load; npx "$@"; }
yarn() { _nvm_load; yarn "$@"; }
pnpm() { _nvm_load; pnpm "$@"; }
codex() { _nvm_load; codex "$@"; }

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Recover DISPLAY inside tmux when the session env stripped it (attaching from
# a DISPLAY-less client sets "-DISPLAY" via update-environment, which breaks
# GUI launches like rifle/zathura from ranger). Only restore if the X socket
# for that display actually exists on this machine.
if [[ -n $TMUX && -z $DISPLAY ]]; then
  _tmux_display=$(tmux show-environment -g DISPLAY 2>/dev/null | cut -d= -f2-)
  if [[ -n $_tmux_display && -S /tmp/.X11-unix/X${${_tmux_display#:}%%.*} ]]; then
    export DISPLAY=$_tmux_display
  fi
  unset _tmux_display
fi

# Private config (work dirs, SSH keys, VPN, etc.) — not tracked by git
[ -f ~/.zshrc-private ] && source ~/.zshrc-private

source ~/Documents/my-utils/git-dir-tracker/git-dir-tracker.sh

# .NET SDK (user-local)
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"

# claude-quota-pilot: cl shorthand for claude-lane
source /home/jakub/Documents/claude-quota-pilot/scripts/cl.zsh
