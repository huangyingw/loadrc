#!/bin/zsh

function get_utf_8_str() {
    host=$1

    if ( ssh -q "$host" "uname" | grep -q Darwin )
    then
        echo "utf-8-mac"
    else
        echo "utf-8"
    fi
}

function main() {
    source=$1
    target=$2

    shost=$(~/loadrc/bashrc/parse_host.sh "$source")
    thost=$(~/loadrc/bashrc/parse_host.sh "$target")

    local_utf_8_str=$(get_utf_8_str "localhost")

    if [ "$shost" != "localhost" ]
    then
        remote_utf_8_str=$(get_utf_8_str $shost)
        echo "--iconv=$local_utf_8_str,$remote_utf_8_str"
    elif [ "$thost" != "localhost" ]
    then
        remote_utf_8_str=$(get_utf_8_str $thost)
        echo "--iconv=$local_utf_8_str,$remote_utf_8_str"
    else
        echo "--iconv=$local_utf_8_str,$local_utf_8_str"
    fi
}

main "$@"
#main ~/loadrc/ mini:~/loadrc/
#main mini:~/loadrc/ ~/loadrc/
#main ~/loadrc/ ~/loadrc/
#main mini:~/loadrc/ mini:~/loadrc/
