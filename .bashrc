# Computer type
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

# Monitors
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

# Useful functions and aliases
#
isInteger () [[ $1 =~ ^-?[0-9]+$ ]]

randHex () {
  if (( $# < 1 )); then
    echo "Usage: randHex <number of bytes>"
    return 1
  fi
  if ! isInteger $1; then
    echo "Error: the first argument must be an integer"
    return 1
  fi
  openssl rand -hex "$1"
}

lr () { # Extract a line range
    if (( $# < 2 )); then
        echo "Usage: ${FUNCNAME[0]} <starting line> <ending line>." >&2
        return 1
    fi
    if ! isInteger $1; then
        echo "Error: starting line is not an integer." >&2
        return 1
    fi
    if ! isInteger $2; then
        echo "Error: ending line is not an integer." >&2
        return 1
    fi
    if (( $1 > $2 )); then
        echo "Error: ending line is larger than starting line." >&2
        return 1
    fi
    local -r start="$1"
    local -r end="$2"
    local -r endPlusOne="$((end+1))"
    sed -n "${start},${end}p;${endPlusOne}q"
}

joinlines () { 
    local joinSymbol=" "
    if (( $# >= 1 )); then
        joinSymbol="$1"
    fi
    local -r joinSymbol="$(sed 's|\([/\&]\)|\\\1|g' <<< "$joinSymbol")"
    sed ":a; N; s/\n/$joinSymbol/; ba";
}

# Get rid of default ctrl+s and ctrl+q bindings
#
stty stop undef
stty start undef
stty quit undef

# Prompt
#
export PS1="\d@\t\n[\$?]\u@\h:\w\\$ "

# History
#
shopt -s histappend
shopt -s histverify
shopt -u histreedit

export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*"
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export PROMPT_COMMAND='history -a'

# Recheck window size after each command
#
shopt -s checkwinsize

# Git aliases
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
alias gsma2='git status | grep modified | c2 | xargs git add'

# Extract columns
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
alias c10='awk '\''{print $10}'\'''

# Head and tail aliases
#
alias h='head'
alias t='tail'
alias h1='head -1'
alias h2='head -2'
alias h3='head -3'
alias h4='head -4'
alias h5='head -5'
alias h6='head -6'
alias h7='head -7'
alias h8='head -8'
alias h9='head -9'
alias h10='head -10'
alias t1='tail -1'
alias t2='tail -2'
alias t3='tail -3'
alias t4='tail -4'
alias t5='tail -5'
alias t6='tail -6'
alias t7='tail -7'
alias t8='tail -8'
alias t9='tail -9'
alias t10='tail -10'

# Use colors in grep
#
alias grep='egrep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# Use more advanced ls
#
alias ls='ls --color=auto -F'

# Enable bash completion
#
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Setup path
#
PATH=$PATH:~/.local/bin

