SCRIPT_HOME=$(dirname $0 | while read a; do cd $a && pwd && break; done)

# syslink configuration files
ln -s $SCRIPT_HOME/antigen.zsh ~/.antigen.zsh
ln -s $SCRIPT_HOME/zshrc ~/.zshrc
ln -s $SCRIPT_HOME/vimrc ~/.vimrc
ln -s $SCRIPT_HOME/tmux.conf ~/.tmux.conf
ln -s $SCRIPT_HOME/tmux-macos.conf ~/.tmux-macos.conf
ln -s $SCRIPT_HOME/tmux-linux.conf ~/.tmux-linux.conf

if [ -d "/Users/macbook/.vim/autoload" ]; then
	ln -s $SCRIPT_HOME/vim/autoload/* /Users/macbook/.vim/autoload/
else
	mkdir -p /Users/macbook/.vim/autoload/
	ln -s $SCRIPT_HOME/vim/autoload/* /Users/macbook/.vim/autoload/
fi

