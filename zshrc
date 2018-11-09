#=============================================================================
# Zplug manager
#=============================================================================

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
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
    export ZSH_THEME=xiong-chiamiov
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
alias update='brew update && brew upgrade'

#=============================================================================
# Functions
#=============================================================================

# get current weather in terminal
function weather()
{
    if [ "$2" = 'F' ] || [ "$2" = 'f' ]; then
        curl wttr.in/$1\?u
    elif [ "$2" = 'C' ] || [ "$2" = 'c' ]; then
        curl wttr.in/$1\?m
    else
        curl wttr.in/$1
    fi
}

# add ctrl-z support
fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
else
    zle push-input
    zle clear-screen
fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# truecolor test
function tc-test()
{
    awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
    printf "\n";
}'
}
