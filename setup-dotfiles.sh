#!/bin/bash

export DOTFILES=".zsh zprofile .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .vimrc .vimrc.bundle .tmux.conf"

for dotfile in $DOTFILES
do  
    if [ -e $HOME/$dotfile ]; then
        unlink $HOME/$dotfile
    fi
    ln -s $HOME/dotfiles/$dotfile $HOME/$dotfile
done

#Directory
if [ -d $HOME/.vim ]; then
    unlink $HOME/.vim
fi

if [ -d $HOME/.zsh ]; then
    unlink $HOME/.zsh
fi

if [ -d $HOME/.tmux ]; then
    unlink $HOME/.tmux
fi

if [ -d $HOME/.gittmp ]; then
    unlink $HOME/.gittmp
fi

#git submodule
git submodule init
git submodule update

ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.zsh $HOME/.zsh
ln -s $HOME/dotfiles/.antigen $HOME/.antigen
ln -s $HOME/dotfiles/.tmux $HOME/.tmux
ln -s $HOME/dotfiles/.gittmp $HOME/.gittmp
