#!/bin/bash
SCRIPT_HOME=$(dirname $0 | while read a; do cd $a && pwd && break; done)

if [[ $OS == Windows* ]]; then
    rm -rf $HOME/vimfiles
    rm -rf $HOME/.vim
    mkdir -p $HOME/vimfiles/{after,autoload}
    ln -s $SCRIPT_HOME/vim/after/* $HOME/vimfiles/after
    ln -s $SCRIPT_HOME/vim/autoload/* $HOME/vimfiles/autoload
    curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
curl -fLo ~/.antigen.zsh git.io/antigen

if [ -d "$HOME/.vim/after" ]; then
    ln -s $SCRIPT_HOME/vim/after/* $HOME/.vim/after
else
    mkdir -p $HOME/.vim/after
    ln -s $SCRIPT_HOME/vim/after/* $HOME/.vim/after
fi

if [ -d "$HOME/.config/nvim" ]; then
    cp -Rs $SCRIPT_HOME/config/nvim/* $HOME/.config/nvim
else
    mkdir -p $HOME/.config/nvim
    cp -Rs $SCRIPT_HOME/config/nvim/* $HOME/.config/nvim
fi

if [ -d "$HOME/.vim/autoload" ]; then
    ln -s $SCRIPT_HOME/vim/autoload/* $HOME/.vim/autoload
else
    mkdir -p $HOME/.vim/autoload
    ln -s $SCRIPT_HOME/vim/autoload/* $HOME/.vim/autoload
fi

# syslink configuration files
if [[ $OS == Windows* ]]; then
    rm -f $HOME/.zshrc
    rm -f $HOME/.gitconfig
    rm -f $HOME/.gitignore
    rm -f $HOME/_vimrc
    rm -f $HOME/.vimrc
    
    ln -s $SCRIPT_HOME/zshrc $HOME/.zshrc
    ln -s $SCRIPT_HOME/gitconfig $HOME/.gitconfig
    ln -s $SCRIPT_HOME/gitignore $HOME/.gitignore
    ln -s $SCRIPT_HOME/vimrc $HOME/_vimrc
fi

ln -s $SCRIPT_HOME/zshrc $HOME/.zshrc
ln -s $SCRIPT_HOME/vimrc $HOME/.vimrc
ln -s $SCRIPT_HOME/tmux.conf $HOME/.tmux.conf
ln -s $SCRIPT_HOME/tmux-macos.conf $HOME/.tmux-macos.conf
ln -s $SCRIPT_HOME/tmux-linux.conf $HOME/.tmux-linux.conf
ln -s $SCRIPT_HOME/gdbinit $HOME/.gdbinit
ln -s $SCRIPT_HOME/gitconfig $HOME/.gitconfig
ln -s $SCRIPT_HOME/gitignore $HOME/.gitignore

if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh
fi
ln -s $SCRIPT_HOME/ssh/config $HOME/.ssh/config
