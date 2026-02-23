export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

#VIM=<base directory where Vim executable is placed>
#VIMRUNTIME=<base directory where Vim runtimes are kept>
#EDITOR=$VIM/vim

VIMRUNTIME=/usr/bin
#EDITOR=/usr/bin/vim TODO: tidy up
export VISUAL=/usr/bin/vim;
export EDITOR=/home/jakub/tools/nvim/nvim
export RIPGREP_CONFIG_PATH=/home/jakub/.ripgreprc
#export EDITOR='/home/jakub/tools/nvim -u /home/jakub/Dropbox/sync/homedir/.config/nvim/init-coc.vim'
export BROWSER="opera"
export TERM="xterm-256color" #required for tmux

export WORKON_HOME=$HOME/.virtualenvs

# https://askubuntu.com/questions/910821/programs-installed-via-snap-not-showing-up-in-launcher
emulate sh -c 'source /etc/profile'

#Run udiskie automount when device plugged
#udiskie -t &

# idle-state-seconds to turn off monitor
xset dpms 0 0 3000

xrdb ~/.Xresources
