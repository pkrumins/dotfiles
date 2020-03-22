#!/bin/bash
#

tmux new-session -s 'ws2' -d
tmux new-window -n 'w1'       "dmesg -T && free && uptime && /bin/bash -i"
tmux new-window -n 'tunnels'
tmux new-window -n 'tools'    -c ~/projects/onlinetools
tmux new-window -n 'catonmat' -c ~/projects/catonmat-new
tmux new-window -n 'br-web'   -c ~/projects/browserling-web
tmux new-window -n 'br-new'   -c ~/projects/browserling-new
tmux new-window -n 'br-comic' -c ~/projects/browserling-comic
tmux new-window -n 'urls'     -c ~/projects/techurls
tmux new-window -n 'gmsg'     -c ~/projects/browserling-gmsg
tmux new-window -n 't'        -c ~/projects
tmux new-window -n 'r'        -c ~/projects

tmux select-window -t "w1"

tmux attach-session -d
