#!/bin/bash
#

set +o history

if xdotool search -classname "calendar" &>/dev/null; then
    i3-msg '[instance="calendar"] kill'
else
    urxvt -name calendar -fn "xft:DejaVu Sans Mono:size=9" -e bash -i -c "ncal -w -b -B 5 -A 6 -M && read -r -s -n 1"
fi

