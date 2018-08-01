SCRIPT_HOME=$(dirname $0 | while read a; do cd $a && pwd && break; done)

# syslink configuration files
ln -s $SCRIPT_HOME/antigen.zsh ~/.antigen.zsh
ln -s $SCRIPT_HOME/zshrc ~/.zshrc
ln -s $SCRIPT_HOME/vimrc ~/.vimrc
ln -s $SCRIPT_HOME/tmux.conf ~/.tmux.conf
ln -s $SCRIPT_HOME/tmux-macos.conf ~/.tmux-macos.conf
ln -s $SCRIPT_HOME/tmux-linux.conf ~/.tmux-linux.conf
ln -s $SCRIPT_HOME/gdbinit ~/.gdbinit

if [ -d "~/.vim/after" ]; then
	ln -s $SCRIPT_HOME/vim/after/* ~/.vim/after/
else
	mkdir -p ~/.vim/after/
	ln -s $SCRIPT_HOME/vim/after/* ~/.vim/after/
fi

if [ -d "~/.vim/autoload" ]; then
	ln -s $SCRIPT_HOME/vim/autoload/* ~/.vim/autoload/
else
	mkdir -p ~/.vim/autoload/
	ln -s $SCRIPT_HOME/vim/autoload/* ~/.vim/autoload/
fi

