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

# enable editing command in an editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# use gpg-agent for ssh authentication
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
#=============================================================================
# Globals
#=============================================================================
export ANDROID_HOME=$HOME/Library/android/sdk/platform-tools:$HOME/.platform-tools
export BAT_THEME="Solarized (dark)"
export BREW_CASKROOM=/usr/local/Caskroom
export BREW_CELLAR=/usr/local/Cellar
export CLICOLOR=1
export EDITOR=/usr/local/bin/vim
export FZF_DEFAULT_OPTS="--exact --bind='F2:toggle-preview'"
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
export PATH=$PATH:$ANDROID_HOME:$HOME/.local/bin
export SSLKEYLOGFILE=$HOME/.ssh_keylogs/ssh.log
export TERM="xterm-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23,underline"

# enable anaconda, if available
if [[ $(uname) == "Darwin" ]]; then
    conda_dir=/opt/miniconda3/etc/profile.d/conda.sh
    if [ -f $conda_dir ]; then 
        source $conda_dir
    fi
else
    conda_dir=$HOME/.anaconda/etc/profile.d/conda.sh
    if [ -f $conda_dir ]; then 
        source $conda_dir
    fi
fi

# enable workflow scripts, if available
[ -f $HOME/.workflow.sh ] && source $HOME/.workflow.sh

# enable FZF, if available
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

#=============================================================================
# Aliases
#=============================================================================
[[ $(uname) != "Darwin" ]] && alias ls='ls --color=auto'

alias .....='cd ../../../../'
alias ....='cd ../../../../'
alias ...='cd ../../../'
alias ..='cd ..'
alias arc='arduino-cli'
alias grep='grep --color=auto'
alias l='ls'
alias la='ls -lrtah'
alias ll='ls -lrth'
alias rmhist='echo "" > $HISTFILE & exec $SHELL -l'
alias sudo='sudo '
alias tx='tmuxp '
alias vi='vim'
#=============================================================================
# Plugins and Themes
#=============================================================================
source $HOME/.zsh_plugins/zsh-git-prompt/zshrc.sh
source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh_plugins/zsh/parrot.zsh-theme
source $HOME/.zsh_plugins/zsh/tmux.plugin.zsh
source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#=============================================================================
# Functions
#=============================================================================
# function to update binaries
function update {
    if ( [ -x "$(command -v apt)" ] && [[ $(uname) != "Darwin" ]] ); then
        sudo apt update && sudo apt upgrade
    elif [ -x "$(command -v brew)" ]; then
        brew update && brew upgrade && brew cleanup --prune 0
    elif [ -x "$(command -v yum)" ]; then
        yum update && yum upgrade
    fi
}

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

