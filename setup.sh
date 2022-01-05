#!/bin/bash
SCRIPT_HOME=$(dirname $0 | while read a; do cd $a && pwd && break; done)

function clone_plugin()
{
    repo=$(echo $1 | awk -F'/' '{print $2}')
    if [ ! -d "$SCRIPT_HOME/zsh_plugins" ]; then
        mkdir $SCRIPT_HOME/zsh_plugins
    fi
    git clone https://github.com/$1.git $SCRIPT_HOME/zsh_plugins/$repo
}

function update_repos()
{
    dir_list=($(ls $SCRIPT_HOME/zsh_plugins))
    for repo in "${dir_list[@]}"; do
        cd $SCRIPT_HOME/zsh_plugins/$repo
        git pull
    done
}

if [[ $OS == Windows* ]]; then
    rm -rf $HOME/vimfiles
    mkdir -p $HOME/vimfiles/{after,autoload}
    ln -s $SCRIPT_HOME/vim/after/* $HOME/vimfiles/after
    ln -s $SCRIPT_HOME/vim/autoload/* $HOME/vimfiles/autoload
    curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    if [ -d "$HOME/.vim/after" ]; then
        ln -s $SCRIPT_HOME/vim/after/* $HOME/.vim/after
    else
        mkdir -p $HOME/.vim/after
        ln -s $SCRIPT_HOME/vim/after/* $HOME/.vim/after
    fi

    if [ -d "$HOME/.vim/autoload" ]; then
        ln -s $SCRIPT_HOME/vim/autoload/* $HOME/.vim/autoload
    else
        mkdir -p $HOME/.vim/autoload
        ln -s $SCRIPT_HOME/vim/autoload/* $HOME/.vim/autoload
    fi
fi

# zsh plugins
clone_plugin "olivierverdier/zsh-git-prompt"
clone_plugin "zsh-users/zsh-syntax-highlighting"
clone_plugin "zsh-users/zsh-completions"
clone_plugin "zsh-users/zsh-autosuggestions"

# syslink configuration files
if [[ $OS == Windows* ]]; then
    rm -rf $HOME/.zsh_plugins
    rm -f $HOME/.zshrc
    rm -f $HOME/.gitconfig
    rm -f $HOME/.gitignore
    rm -f $HOME/_vimrc
    
    ln -s $SCRIPT_HOME/zsh_plugins $HOME/.zsh_plugins
    ln -s $SCRIPT_HOME/zshrc $HOME/.zshrc
    ln -s $SCRIPT_HOME/gitconfig $HOME/.gitconfig
    ln -s $SCRIPT_HOME/gitignore $HOME/.gitignore
    ln -s $SCRIPT_HOME/vimrc $HOME/_vimrc
else
    ln -s $SCRIPT_HOME/zsh_plugins $HOME/.zsh_plugins
    ln -s $SCRIPT_HOME/zsh zsh_plugins
    ln -s $SCRIPT_HOME/zshrc $HOME/.zshrc
    ln -s $SCRIPT_HOME/vimrc $HOME/.vimrc
    ln -s $SCRIPT_HOME/tmux.conf $HOME/.tmux.conf
    ln -s $SCRIPT_HOME/tmux-macos.conf $HOME/.tmux-macos.conf
    ln -s $SCRIPT_HOME/tmux-linux.conf $HOME/.tmux-linux.conf
    ln -s $SCRIPT_HOME/gdbinit $HOME/.gdbinit
    ln -s $SCRIPT_HOME/gitconfig $HOME/.gitconfig
    ln -s $SCRIPT_HOME/gitignore $HOME/.gitignore
fi
if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh
fi
ln -s $SCRIPT_HOME/ssh/config $HOME/.ssh/config

update_repos
