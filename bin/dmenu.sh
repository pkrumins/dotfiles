#!/bin/bash -i
#

set -ueo pipefail

dmenu_choice () {
    local -ar choices=("$@");
    local -r IFS=$'\n'
    echo -e "${choices[*]}" | dmenu -i
}

main () {
    local -Ar browsing=(
        ["chrome"]="chrome-browsing"
        ["gmail"]="gmail"
        ["google"]="g"
        ["fb"]="fb"
        ["hn"]="hn"
        ["reddit"]="reddit"
        ["lobsters"]="lobsters"
        ["statc"]="statc"
        ["catonmat"]="chrome-browsing https://catonmat.net"
        ["techurls"]="techurls"
        ["devurls"]="devurls"
        ["sciurls"]="sciurls"
        ["finurls"]="finurls"
        ["mathurls"]="mathurls"
        ["csv"]="chrome-browsing https://onlinecsvtools.com"
        ["lcsv"]="chrome-browsing http://local.csvtools.browserling.com"
        ["tsv"]="chrome-browsing https://onlinetsvtools.com"
        ["ltsv"]="chrome-browsing http://local.tsvtools.browserling.com"
        ["json"]="chrome-browsing https://onlinejsontools.com"
        ["ljson"]="chrome-browsing http://local.jsontools.browserling.com"
        ["xml"]="chrome-browsing https://onlinexmltools.com"
        ["lxml"]="chrome-browsing http://local.xmltools.browserling.com"
        ["yaml"]="chrome-browsing https://onlineyamltools.com"
        ["lyaml"]="chrome-browsing http://local.yamltools.browserling.com"
        ["string"]="chrome-browsing https://onlinestringtools.com"
        ["lstring"]="chrome-browsing http://local.stringtools.browserling.com"
        ["random"]="chrome-browsing https://onlinerandomtools.com"
        ["lrandom"]="chrome-browsing http://local.randomtools.browserling.com"
        ["binary"]="chrome-browsing https://onlinebinarytools.com"
        ["lbinary"]="chrome-browsing http://local.binarytools.browserling.com"
        ["png"]="chrome-browsing https://onlinepngtools.com"
        ["lpng"]="chrome-browsing http://local.pngtools.browserling.com"
        ["hex"]="chrome-browsing https://onlinehextools.com"
        ["lhex"]="chrome-browsing http://local.hextools.browserling.com"
        ["jpg"]="chrome-browsing https://onlinejpgtools.com"
        ["ljpg"]="chrome-browsing http://local.jpgtools.browserling.com"
        ["ascii"]="chrome-browsing https://onlineasciitools.com"
        ["lascii"]="chrome-browsing http://local.asciitools.browserling.com"
        ["math"]="chrome-browsing https://onlinemathtools.com"
        ["lmath"]="chrome-browsing http://local.mathtools.browserling.com"
        ["image"]="chrome-browsing https://onlineimagetools.com"
        ["limage"]="chrome-browsing http://local.imagetools.browserling.com"
        ["utf8"]="chrome-browsing https://onlineutf8tools.com"
        ["lutf8"]="chrome-browsing http://local.utf8tools.browserling.com"
        ["text"]="chrome-browsing https://onlinetexttools.com"
        ["ltext"]="chrome-browsing http://local.texttools.browserling.com"
        ["number"]="chrome-browsing https://onlinenumbertools.com"
        ["lnumber"]="chrome-browsing http://local.numbertools.browserling.com"
        ["fractal"]="chrome-browsing https://onlinefractaltools.com"
        ["lfractal"]="chrome-browsing http://local.fractaltools.browserling.com"
        ["unicode"]="chrome-browsing https://onlineunicodetools.com"
        ["lunicode"]="chrome-browsing http://local.unicodetools.browserling.com"
    )

    local -r choice="$(dmenu_choice "${!browsing[@]}")"
    if [[ -v "browsing[$choice]" ]]; then
        eval "${browsing[$choice]}"
    fi
}

main "$@"

