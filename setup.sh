#!/bin/bash

CONFIG_DIR=$HOME/.config
NVIM_DIR=$CONFIG_DIR/nvim
TMUX_DIR=$HOME/.tmux
TMUX_CONF=$HOME/.tmux.conf
NVIM_CONF=$NVIM_DIR/init.vim
VIM_CONF=$HOME/.vimrc
ZSHRC=$HOME/.zshrc
ZSH_BULLET_TRAIN_THEME=$HOME/.oh-my-zsh/custom/themes/bullet-train.zsh-theme

echo 'Checking for pre-existing files and directories'

function run_command() {
    echo $1
    eval $1
}

function prompt_user() {
    while true; do
        read -p "$1 Continue? (Y/N)" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done

}

function remove_pre_existing() {
    if [ -e $1 ]; then
        prompt_user "Removing pre-existing $1!"
        run_command "rm -rf $1"
    fi
}

function link() {
    echo 'Symlinking' $2 ' -> ' $1
    run_command "ln -s $1 $2"
}


remove_pre_existing $VIM_CONF
remove_pre_existing $NVIM_DIR
remove_pre_existing $TMUX_DIR
remove_pre_existing $TMUX_CONF
remove_pre_existing $ZSHRC
remove_pre_existing $ZSH_BULLET_TRAIN_THEME

link `pwd`/zshrc $ZSHRC
echo 'zshrc file installed successfully!'

link `pwd`/nvim $NVIM_DIR
echo 'Nvim directory installed successfully!'

link `pwd`/tmux $TMUX_DIR 
echo 'Tmux directory installed successfully!'

link `pwd`/tmux.conf $TMUX_CONF
echo 'Tmux conf installed successfully!'

link `pwd`/nvim/init.vim $VIM_CONF
echo 'Vim .vimrc compatability symlink installed successfully!'

link `pwd`/zsh_theme/bullet_train.zsh/bullet-train.zsh-theme $ZSH_BULLET_TRAIN_THEME
echo 'Bullet train ZSH theme was installed successfully!'

