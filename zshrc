
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [[ `uname -m` == 'arm64' ]]; then
    export PATH=/opt/homebrew/bin:$PATH
fi

export PATH=$PATH:$HOME/.yarn/bin

# Don't save history for less
export LESSHISTFILE=/dev/null

plugins=(
    zsh-autosuggestions
)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#424242"
BULLETTRAIN_KCTX_BG=magenta
BULLETTRAIN_PROMPT_CHAR=
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ORDER=(
    time
    kctx
    status
    custom
    dir
    git
    )
ZSH_THEME="bullet-train"

export XDG_CONFIG_HOME=$HOME/.config
export COLORTERM=truecolor
export BAT_THEME="Visual Studio Dark+"
export EDITOR=nvim

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias nvimdiff="nvim -d"
alias tmux="tmux -2"
alias ipython="python3 -m IPython"
alias ls="lsd"
alias python=python3
alias pip=pip3
LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.extras.zsh ] && source ~/.extras.zsh
