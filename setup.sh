SCRIPT_HOME=$(dirname $0 | while read a; do cd $a && pwd && break; done)

# syslink configuration files
ln -s $SCRIPT_HOME/antigen.zsh ~/.antigen.zsh
ln -s $SCRIPT_HOME/zshrc ~/.zshrc
ln -s $SCRIPT_HOME/vimrc ~/.vimrc
ln -s $SCRIPT_HOME/tmux-macos.conf ~/.tmux-macos.conf
ln -s $SCRIPT_HOME/tmux-linux.conf ~/.tmux-linux.conf

# download vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
