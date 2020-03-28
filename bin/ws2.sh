#!/bin/bash
#

if { tmux list-sessions | grep -q ^ws2; } 1>/dev/null 2>&1; then
    tmux attach-session -d -t "ws2"
else
    tmux new-session -s 'ws2' -n "0" -d

    tmux new-window -n 'tun'
    tmux new-window -n 'tools'    -c ~/projects/onlinetools
    tmux new-window -n 'catonmat' -c ~/projects/catonmat-new
    tmux new-window -n 'br-web'   -c ~/projects/browserling-web
    tmux new-window -n 'br-new'   -c ~/projects/browserling-new
    tmux new-window -n 'br-comic' -c ~/projects/browserling-comic
    tmux new-window -n 'urls'     -c ~/projects/techurls
    tmux new-window -n 'dotf'     -c ~/projects/dotfiles

    tmux select-window -t "0"

    tmux attach-session -d
fi
