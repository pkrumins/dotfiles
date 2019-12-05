# computer type
#
if [[ ! -f $HOME/.computer-desktop && ! -f $HOME/.computer-laptop  && ! -f $HOME/.computer-server ]]; then
    echo "Computer type is not set. Setting it to desktop."
    export COMPUTER_TYPE=desktop
fi

if [[ -f $HOME/.computer-desktop ]]; then
    export COMPUTER_TYPE=desktop
elif [[ -f $HOME/.computer-laptop ]]; then
    export COMPUTER_TYPE=laptop
elif [[ -f $HOME/.computer-server ]]; then
    export COMPUTER_TYPE=server
fi

# monitors
#
export MONITOR_COUNT=1
if [[ -v "DISPLAY" ]]; then
    export MONITOR_COUNT="$(xrandr | grep "\<connected\>" | wc -l)"
fi

if [[ $COMPUTER_TYPE == "desktop" ]]; then
    export MONITOR_PRIMARY="VGA1"
    if (( $MONITOR_COUNT >= 2 )); then
        export MONITOR_SECONDARY="DP1"
    fi
elif [[ $COMPUTER_TYPE == "laptop" ]]; then
    export MONITOR_PRIMARY="eDP1"
    if (( $MONITOR_COUNT >= 2 )); then
        export MONITOR_SECONDARY="DP1"
    fi
fi

# helper functions
#
isInteger () [[ $1 =~ ^-?[0-9]+$ ]]

# get rid of default ctrl+s and ctrl+q bindings
#
stty stop undef
stty start undef
stty quit undef

# prompt
#
export PS1="\d@\t\n[\$?]\u@\h:\w\\$ "

# history
#
shopt -s histappend
shopt -s histverify
shopt -u histreedit

export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*"
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export PROMPT_COMMAND='history -a'

# recheck window size after each command
#
shopt -s checkwinsize

# git aliases
#
alias ga='git add'
alias ga2='awk '\''{print $2}'\'' | xargs git add'
alias ga3='awk '\''{print $3}'\'' | xargs git add'
alias gm='git commit -m'
alias gp='git push'
alias gpu='git pull'
alias gl='git log'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gc='git checkout'
alias gs='git status'
alias gsl='git status | less'
alias gsm='git status | grep modified'
alias gsml='git status | grep modified | less'

# extract columns
#
alias c1='awk '\''{print $1}'\'''
alias c2='awk '\''{print $2}'\'''
alias c3='awk '\''{print $3}'\'''
alias c4='awk '\''{print $4}'\'''
alias c5='awk '\''{print $5}'\'''
alias c6='awk '\''{print $6}'\'''
alias c7='awk '\''{print $7}'\'''
alias c8='awk '\''{print $8}'\'''
alias c9='awk '\''{print $9}'\'''

# cd and ls aliases
#
alias c='cd'
alias l='ls'

# head and tail aliases
#
alias h='head'
alias t='tail'
alias h10='head -10'
alias t10='tail -10'

# extract a line range
lr () { 
    if (( $# < 2 )); then
        echo "usage: lr <starting line> <ending line>" >&2
        return 1
    fi
    if ! isInteger $1; then
        echo "error: starting line is not an integer" >&2
        return 1
    fi
    if ! isInteger $2; then
        echo "error: ending line is not an integer" >&2
        return 1
    fi
    if (( $1 > $2 )); then
        echo "error: ending line is larger than starting line" >&2
        return 1
    fi
    local start="$1"
    local end="$2"
    local endPlusOne="$((end+1))"
    sed -n "${start},${end}p;${endPlusOne}q"
}

# join lines together
#
joinlines () {
    local joinSymbol=" "
    if (( $# >= 1 )); then
        joinSymbol="$1"
    fi
    sed ":a; N; s/\n/$joinSymbol/; ba";
}

# egrep for grep
#
alias grep='egrep --color'
alias g='grep'
alias gi='grep -i'
alias gv='grep -v'
alias gvi='grep -vi'
