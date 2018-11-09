#=============================================================================
# Antigen
#=============================================================================
source .antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle git
antigen bundle heroku
antigen bundle lein
antigen bundle pip
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# Oh-my-ZSH plugins
plugins=( rake rails laravel4 mysql tmux )


#=============================================================================
# Globals
#=============================================================================
export ANDROID_HOME=$HOME/Library/android/sdk
export EDITOR="vim"
export LESS_TERMCAP_se=$'\E[39;49m'
export LESS_TERMCAP_so=$'\E[30;43m'
export PATH=$PATH:$ANDROID_HOME/platform-tools
export TERM="screen-256color"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
export ZSH_THEME=xiong-chiamiov

if [[ $OSTYPE =~ "darwin" ]] && 
      ! type "reattach-to-user-namespace" > /dev/null; then
    echo "reattach-to-user-namespace not installed, tmux will not auto-start"
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
#=============================================================================
source $ZSH/oh-my-zsh.sh
#=============================================================================
