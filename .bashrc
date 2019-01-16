# prompt
#
export PS1="\d@\t\n[\$?]\u@\h:\w$ "

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

# extract columns quickly
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
alias grep='egrep --color';
alias g='grep'

