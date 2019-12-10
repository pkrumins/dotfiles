#!/bin/bash
#

set -ueo pipefail

main () {
    local -r text=' abcABC '
    local -r textLen="${#text}"

    local -r bgColors=(
        40  41  42  43  44  45  46  47
    );
    local -r fgColors=(
        ''
        1
        30 '1;30' 31 '1;31' 32 '1;32' 33 '1;33' 34 '1;34' 35 '1;35' 36 '1;36' 37 '1;37'
    );

    printf "%-$((textLen*2))s" " "
    printf "%-$((textLen+1))s" "${bgColors[@]}"
    echo

    for fgColor in "${fgColors[@]}"; do
        fgColorFmt="$(printf "%-5s" "$fgColor")"
        echo -ne "$fgColorFmt \033[${fgColor}m${text}\033[0m "
        for bgColor in "${bgColors[@]}"; do
            echo -ne "\033[${fgColor};${bgColor}m${text}\033[0m "
        done
        echo
    done
}

main "$@"

