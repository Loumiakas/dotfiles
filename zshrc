#=============================================================================
#  Shell settings
#=============================================================================
fpath=($HOME/.zsh_plugins/zsh-completions/src $fpath)
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
setopt appendhistory
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit && compinit
#=============================================================================
# Globals
#=============================================================================
if [[ -z $TMUX ]]; then
    export ANDROID_HOME=$HOME/Library/android/sdk
    export CLICOLOR=1
    export EDITOR="vim"
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
    export TERM="xterm-256color"
fi

cmd="reattach-to-user-namespace"
if [[ $OSTYPE =~ "darwin" ]] && ! type $cmd > /dev/null; then
    echo "Failed to auto-start tmux - $cmd is not installed"
    export ZSH_TMUX_AUTOSTART=false
else
    export ZSH_TMUX_AUTOSTART=true
fi

if [ -f ".workflow.sh" ]; then
    source .workflow.sh
fi
#=============================================================================
# Aliases
#=============================================================================
alias .....='cd ../../../../'
alias ....='cd ../../../../'
alias ...='cd ../../../'
alias ..='cd ..'
alias grep='grep --color=auto -nfdsa'
alias l='ls'
alias la='ls -lrtah'
alias ll='ls -lrth'
alias sudo='sudo '
alias update='brew update; brew upgrade --all; brew cask upgrade; brew cleanup'
#=============================================================================
# Plugins and Themes
#=============================================================================
source $HOME/.zsh_plugins/zsh-git-prompt/zshrc.sh
source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh_plugins/zsh/loumiakas.zsh-theme
source $HOME/.zsh_plugins/zsh/tmux.plugin.zsh
source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# disable hooks that slow down performance
add-zsh-hook -d chpwd   chpwd_update_git_vars
add-zsh-hook -d preexec preexec_update_git_vars
add-zsh-hook -d precmd  precmd_update_git_vars
