# helper functions
#
isInteger () [[ $1 =~ '^-?[0-9]+$' ]]

# prompt
#
export PS1="\d@\t\n[\$?]\u@\h:\w$ "

# history
#
shopt -s histverify
shopt -u histreedit
export HISTIGNORE="&:[ ]*"
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export PROMPT_COMMAND='history -a'

# git aliases
#
alias ga='git add'
alias gm='git commit -m'
alias gp='git push'
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

