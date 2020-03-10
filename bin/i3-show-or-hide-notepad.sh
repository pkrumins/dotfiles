#!/bin/bash
#

set +o history

if xdotool search -classname "notepad" &>/dev/null; then
    # Notepad is running.
    # 1) If it's focused, then put it in scratchpad.
    # 2) If it's not focused, then focus it.
    #
    activeWinId="$(xdotool getactivewindow)";
    activeWinClass="$(xprop -id $activeWinId WM_CLASS | \
        sed -r -e 's/[^"]+//' -e 's/, .+//' -e 's/"//g')";

    if [[ "$activeWinClass" == "notepad" ]]; then
        # 1) Notepad is focused, put it in scratchpad
        i3-msg '[instance="notepad"] move scratchpad'
    else
        # 1) Notepad is not focused, focus it.
        i3-msg '[instance="notepad"] scratchpad show'
    fi
else
    # Notepad is not running. Start it in ~/Downloads.
    #
    cd ~/Downloads
    urxvt -name notepad -fn "xft:DejaVu Sans Mono:size=12" -e vim -c 'startinsert'
fi

