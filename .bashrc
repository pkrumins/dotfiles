# Vi mode
#
set -o vi

# Computer type
#
if [[ ! -f /.computer-desktop && ! -f /.computer-laptop  && ! -f /.computer-server ]]; then
    echo "Computer type is not set. Setting it to desktop."
    export COMPUTER_TYPE=desktop
fi

if [[ -f /.computer-desktop ]]; then
    export COMPUTER_TYPE=desktop
elif [[ -f /.computer-laptop ]]; then
    export COMPUTER_TYPE=laptop
elif [[ -f /.computer-server ]]; then
    export COMPUTER_TYPE=server
fi

# Monitors
#
. ~/projects/dotfiles/.bashrc-monitors

# Colors
#
COLOR_RESET="\033[0m"

COLOR_BLACK="\033[30m"
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_MAGENTA="\033[35m"
COLOR_CYAN="\033[36m"
COLOR_GRAY="\033[37m"

COLOR_BOLD_BLACK="\033[1;30m"
COLOR_BOLD_DRED="\033[1;31m"
COLOR_BOLD_GREEN="\033[1;32m"
COLOR_BOLD_YELLOW="\033[1;33m"
COLOR_BOLD_BLUE="\033[1;34m"
COLOR_BOLD_MAGENTA="\033[1;35m"
COLOR_BOLD_CYAN="\033[1;36m"
COLOR_BOLD_GRAY="\033[1;37m"

BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_GRAY="\033[47m"

# Useful functions and aliases
#
isInteger () [[ $1 =~ ^-?[0-9]+$ ]]

randHex () {
    if (( $# < 1 )); then
        echo "Usage: randHex <number of digits>"
        return 1
    fi
    local -r length="$1"
    if ! isInteger "$length"; then
        echo "Error: the first argument must be an integer"
        return 1
    fi
    if (( $length % 2 == 0 )); then
        local -r bytes="$((length / 2))"
    else
        local -r bytes="$((length / 2 + 1))"
    fi
    openssl rand -hex "$bytes"
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

join_strings () {
    if (( $# < 2 )); then
        echo "Usage: ${FUNCNAME[0]} <separator> <string1> [string2 ...]"
        exit 1
    fi

    local -r separator="$1" && shift
    local -r strings=("$@")
    local -r IFS="$separator"

    echo "${strings[*]}"
}

join_lines () {
    local joinSymbol=" "
    if (( $# >= 1 )); then
        joinSymbol="$1"
    fi
    local -r joinSymbol="$(sed 's|\([/\&]\)|\\\1|g' <<< "$joinSymbol")"
    sed ":a; N; s/\n/$joinSymbol/; ba";
}

# Desktop and laptop aliases
#
if [[ $COMPUTER_TYPE == "desktop" || $COMPUTER_TYPE == "laptop" ]]; then
    alias audiostatus='amixer get Master'
    alias audiomute='amixer -D pulse set Master mute'
    alias audiooff=audiomute
    alias muteaudio=audiomute
    alias audiounmute='amixer -D pulse set Master unmute'
    alias audioon=audiounmute
    alias unmuteaudio=audiounmute
    alias incvol="amixer set Master 5%+"
    alias decvol="amixer set Master 5%-"

    alias micstatus='amixer get Capture'
    alias micmute='amixer set Capture nocap'
    alias micoff=micmute
    alias mutemic=micmute
    alias micunmute='amixer set Capture cap'
    alias micon=micunmute
    alias unmutemic=micunmute

    alias ws='i3-msg workspace'

    alias pkgfiles='dpkg-query -L'

    alias y='xsel -ib && xsel -ob | xsel -ip'
    alias p='xsel -ob'

    br () {
        if (( $# < 1 )); then
            echo "Usage: br <brightness level>"
            return 1
        fi
        xrandr --output $MONITOR_PRIMARY --brightness $1
        if (( $MONITOR_COUNT >= 2 )); then
            xrandr --output $MONITOR_SECONDARY --brightness $1
        fi
    }

    alias i3c='vim ~/.config/i3/config'

    ytdownload () {
        if (( $# < 2 )); then
            echo "Usage: ytdownload <video quality> [args] <urls>"
            return 1;
        fi
        local quality="$1" && shift
        if ! isInteger "$quality"; then
            echo "Error: Video quality is not an integer."
            return 1;
        fi
        local -r formats=(
            "best[ext=mp4][height=$quality]"
            "bestvideo[ext=mp4][height=$quality]+bestaudio[ext=m2a][abr<=128]"
            "bestvideo[ext=mp4][height=$quality]+bestaudio[ext=webm][abr<=128]"
            "bestvideo[ext=mp4][height=$quality]+bestaudio[ext=mp3][abr<=128]"
            "bestvideo[ext=mp4][height=$quality]+bestaudio[ext=aac][abr<=128]"
        )
        local -r formatStr="$(join_strings "/" "${formats[@]}")"
        local -r argsUrls=("$@")
        youtube-dl-docker --no-mtime -f "$formatStr" "${argsUrls[@]}"
    }

    alias ytdownload-480='ytdownload 480'
    alias ytdownload-720='ytdownload 720'
    alias youtube-dl='youtube-dl-docker'

    function hr () {
        local -r cols="${COLUMNS:-$(tput cols)}"
        printf "%${cols}s\n" | sed 's/ /─/g'
    }

    # Load docker aliases
    #
    . ~/projects/dotfiles/.bashrc-docker
fi

# Get rid of default ctrl+s and ctrl+q bindings
#
stty stop undef
stty start undef
stty quit undef

# Prompt
#
prompt_command () {
    local -r last_exit_code="$?"
    history -a
    if (( last_exit_code == 0 )); then
        local -r status_str="\[${COLOR_GREEN}\][0]\[${COLOR_RESET}\]"
    else
        local -r status_str="\[${COLOR_RED}\][$last_exit_code]\[${COLOR_RESET}\]"
    fi
    export PS1="\d@\t\n${status_str}\[${COLOR_BOLD_GREEN}\]\u@\h\[${COLOR_RESET}\]:\[${COLOR_BOLD_BLUE}\]\w\[${COLOR_RESET}\]\\$ "
}
export PROMPT_COMMAND=prompt_command

# History
#
shopt -s histappend
shopt -s histverify
shopt -u histreedit

export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[ ]*"
export HISTFILESIZE=10000000
export HISTSIZE=10000000

# Recheck window size after each command
#
shopt -s checkwinsize

# Git aliases
#
alias ga='git add'
alias ga1='git status | grep modified | lr 1 1 | c2 | xargs git add'
alias ga2='git status | grep modified | lr 2 2 | c2 | xargs git add'
alias ga3='git status | grep modified | lr 3 3 | c2 | xargs git add'
alias ga4='git status | grep modified | lr 4 4 | c2 | xargs git add'
alias ga5='git status | grep modified | lr 5 5 | c2 | xargs git add'
alias ga6='git status | grep modified | lr 6 6 | c2 | xargs git add'
alias ga7='git status | grep modified | lr 7 7 | c2 | xargs git add'
alias ga8='git status | grep modified | lr 8 8 | c2 | xargs git add'
alias ga9='git status | grep modified | lr 9 9 | c2 | xargs git add'
alias gm='git commit -m'
alias gp='git push'
alias gpu='git pull'
alias gl='git log | less -RFX --pattern "^commit "'
alias gd='git diff'
alias gdf='git diff | diff-so-fancy | less --tabs=4 -RFX --pattern "^(commit|added:|deleted:|modified:) "'
alias gd1='git status | grep modified | lr 1 1 | c2 | xargs git diff'
alias gd2='git status | grep modified | lr 2 2 | c2 | xargs git diff'
alias gd3='git status | grep modified | lr 3 3 | c2 | xargs git diff'
alias gd4='git status | grep modified | lr 4 4 | c2 | xargs git diff'
alias gd5='git status | grep modified | lr 5 5 | c2 | xargs git diff'
alias gd6='git status | grep modified | lr 6 6 | c2 | xargs git diff'
alias gd7='git status | grep modified | lr 7 7 | c2 | xargs git diff'
alias gd8='git status | grep modified | lr 8 8 | c2 | xargs git diff'
alias gd9='git status | grep modified | lr 9 9 | c2 | xargs git diff'
alias gdc='git diff --cached'
alias gdcf='git diff --cached | diff-so-fancy | less --tabs=4 -RFX --pattern "^(commit|added:|deleted:|modified:) "'
alias gdc1='git status | grep modified | lr 1 1 | c2 | xargs git diff --cached'
alias gdc2='git status | grep modified | lr 2 2 | c2 | xargs git diff --cached'
alias gdc3='git status | grep modified | lr 3 3 | c2 | xargs git diff --cached'
alias gdc4='git status | grep modified | lr 4 4 | c2 | xargs git diff --cached'
alias gdc5='git status | grep modified | lr 5 5 | c2 | xargs git diff --cached'
alias gdc6='git status | grep modified | lr 6 6 | c2 | xargs git diff --cached'
alias gdc7='git status | grep modified | lr 7 7 | c2 | xargs git diff --cached'
alias gdc8='git status | grep modified | lr 8 8 | c2 | xargs git diff --cached'
alias gdc9='git status | grep modified | lr 9 9 | c2 | xargs git diff --cached'
alias gb='git branch'
alias gc='git checkout'
alias gs='git status'
alias gsl='git -c color.status=always status | less -RFX'
alias gsf='git show | diff-so-fancy | less --tabs=4 -RFX --pattern "^(commit|added:|deleted:|modified:) "'
alias gsm='git status | grep modified'
alias gsml='git status | grep modified | less'
alias gsma2='git status | grep modified | c2 | xargs git add'
alias grh='git reset HEAD'

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

# Shorter wc -l
#
alias wcl='wc -l'

# Setup colors for grep and ls
#
if [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b)"
fi

# Use colors in grep
#
alias grep='egrep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# Use more advanced ls
#
alias ls='ls --color=auto -F'

# Read man through most
#
alias man='PAGER=most man'

# Make less quit if there's less than one screen of text and enable colors
#
export LESS="-F -X -R"

# Make ncdu readonly
#
alias ncdu='ncdu -r'

# Enable bash completion
#
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Enable fzf shortcuts
#
. ~/projects/dotfiles/.bashrc-fzf

# Auto-complete with qq
#
FZF_COMPLETION_TRIGGER="qq"
. ~/projects/dotfiles/.bashrc-fzf-completion

# Use ripgrep in fzf
#
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden -g '!.git' -g '!.dockerdata/chrome' -g '!node_modules'"

# Use ripgrep for ctrl+f
#
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Show file preview with bat with ctrl+f
#
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"

# Use fd for ctrl+g
#
export FZF_ALT_C_COMMAND="fd --type d --no-ignore -H -E '.git' -E '.dockerdata/chrome' -E 'node_modules'"

# Show directory tree with ctrl+g
#
export FZF_ALT_C_OPTS="--preview 'tree -a -I .git -rtC {}'"

# Show multi line history with ctrl+r
#
export FZF_CTRL_R_OPTS="--ansi --preview-window wrap:down:2 --preview 'bat -l bash --color=always --style=plain <(echo {} | sed s/^[0-9\ ]//)'"

# Enable z
#
. ~/projects/dotfiles/z

# Use z with fz
#
. ~/projects/dotfiles/fz

# Use z with fzf
#
unalias z
z() {
    if [[ -z "$@" ]]; then
        cd "$(_z -l 2>&1 | fzf +s --tac --height 15 --reverse -n 2.. | sed -r 's/^[0-9,. ]*//')"
    else
        _z "$@"
    fi
}

# Use v with fzf
#
v() {
    if [[ -z "$@" ]]; then
        local -r choice="$(command v -l 2>&1 | fzf +s --tac --height 15 --reverse | sed -r 's/^[0-9,. \t]*//')"
        if [[ ! -z "$choice" ]]; then
            local -r file="${choice/#~/$HOME}"
            vim "$file"
        fi
    else
        command v "$@"
    fi
}

# Setup path
#
PATH=$PATH:~/.local/bin

