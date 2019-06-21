#=============================================================================
#  Shell settings
#=============================================================================
fpath=($HOME/.zsh_plugins/zsh-completions/src $fpath)
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
setopt share_history
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit && compinit
#=============================================================================
# Globals
#=============================================================================
export ANDROID_HOME=$HOME/Library/android/sdk
export CLICOLOR=1
export EDITOR=/usr/local/bin/vim
export HISTFILE=$HOME/.zsh_history
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\E[39;49m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export PATH=$PATH:$ANDROID_HOME/platform-tools
export SSLKEYLOGFILE=$HOME/.ssh_keylogs/ssh.log
export TERM="xterm-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23,underline"

# check if tmux clipboard dependencies are present
cmd="reattach-to-user-namespace"
if [[ $OSTYPE =~ "darwin" ]] && ! type $cmd > /dev/null; then
    echo "Failed to auto-start tmux - $cmd is not installed"
    export ZSH_TMUX_AUTOSTART=false
else
    export ZSH_TMUX_AUTOSTART=true
fi

# enable anaconda, if available
[ -d $HOME/.anaconda ] && source $HOME/.anaconda/etc/profile.d/conda.sh

# enable workflow scripts, if available
[ -f $HOME/.workflow.sh ] && source $HOME/.workflow.sh

# enable FZF, if available
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
#=============================================================================
# Aliases
#=============================================================================
alias .....='cd ../../../../'
alias ....='cd ../../../../'
alias ...='cd ../../../'
alias ..='cd ..'
alias grep='grep --color=auto'
alias l='ls'
alias la='ls -lrtah'
alias ll='ls -lrth'
alias rmhist='echo "" > $HISTFILE & exec $SHELL -l'
alias sudo='sudo '
alias tx='tmuxp '
alias update='brew update; brew upgrade; brew cask upgrade; brew cleanup'
#=============================================================================
# Plugins and Themes
#=============================================================================
source $HOME/.zsh_plugins/zsh-git-prompt/zshrc.sh
source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh_plugins/zsh/loumiakas.zsh-theme
source $HOME/.zsh_plugins/zsh/tmux.plugin.zsh
source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#=============================================================================
# Functions
#=============================================================================
# function to generate ctags
function gtags {
    if [[ $1 = 'cpp' ]]; then
        echo "Generating tags using C/C++ configuration..."
        ctags -R --c++-kinds=+p --fields=+iaS --extras=+q -h=".c.cc.c++.cxx.cpp.cxx.h.hpp.C"
    else
        echo "Generating tags using default configuration..."
        ctags -R
    fi
}
# function to kill a process based on the name
function pskill {
    if [ -z $1 ]; then
       echo 'pskill <process_name>'
       return 1
    fi
    ps -ef | grep $1 | grep -v grep | awk -F ' ' '{print $2}' | xargs kill -9
}
# disable hooks that slow down performance
add-zsh-hook -d chpwd   chpwd_update_git_vars
add-zsh-hook -d preexec preexec_update_git_vars
add-zsh-hook -d precmd  precmd_update_git_vars

