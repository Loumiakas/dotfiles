#=============================================================================
# Shell settings
#=============================================================================
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#=============================================================================
# Globals
#=============================================================================
if [[ -z $TMUX ]]; then
    export ANDROID_HOME=$HOME/Library/android/sdk
    export EDITOR="vim"
    export LESS_TERMCAP_se=$'\E[39;49m'
    export LESS_TERMCAP_so=$'\E[30;43m'
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export TERM="screen-256color"
    export HISTFILE=$HOME/.zsh_history
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
alias sudo='sudo '
alias ls='ls -G'
alias update='brew update && brew upgrade'

#=============================================================================
# Plugins and Themes
#=============================================================================
fpath=($HOME/.zsh_plugins/zsh-completions/src $fpath)
source $HOME/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh_plugins/zsh-git-prompt/zshrc.sh
source $HOME/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh_plugins/zsh/tmux.plugin.zsh
source $HOME/.zsh_plugins/zsh/trapd00r.zsh-theme
