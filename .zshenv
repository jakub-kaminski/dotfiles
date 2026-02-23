GOPATH=$HOME/go
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH=$PATH:$HOME/.local
PATH=$PATH:$HOME/tools/nvim

#Adding scripts from dotfiles
PATH=$PATH:~/.scripts
PATH=$PATH:~/.scripts/work

PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
PATH='/bin:/sbin':"$PATH"
PATH='/usr/local/MATLAB/R2019a/bin/glnxa64':"$PATH" #mlint
PATH=$PATH:/usr/local/MATLAB/R2019a/bin/matlab

PATH=$PATH:$HOME/.local/bin/pipenv


LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libexpat.so

export PATH
export  GOPATH
export PATH="/usr/bin:$PATH"
. "$HOME/.cargo/env"
