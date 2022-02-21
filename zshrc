
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ `uname -m` == 'arm64' ]]; then
    export PATH=$PATH:/opt/homebrew/bin
fi

# Don't save history for less
export LESSHISTFILE=/dev/null

BULLETTRAIN_PROMPT_CHAR=
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ORDER=(
    time
    status
    custom
    dir
    git
    )
ZSH_THEME="bullet-train"

export COLORTERM=truecolor

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias tmux="tmux -2"
alias ls="lsd"
LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
