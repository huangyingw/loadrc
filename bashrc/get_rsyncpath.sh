#!/bin/zsh

source=$1
target=$2

shost=$(~/loadrc/bashrc/parse_host.sh "$source")
thost=$(~/loadrc/bashrc/parse_host.sh "$target")

function get_rsyncpath()
{
    host=$1
    echo $(ssh "$host" ". ~/loadrc/.pathrc ; which rsync")
}

if [ "$shost" != "localhost" ]
then
    rsyncpath=$(get_rsyncpath $shost)
    echo "--rsync-path=$rsyncpath"
elif [ "$thost" != "localhost" ]
then
    rsyncpath=$(get_rsyncpath $thost)
    echo "--rsync-path=$rsyncpath"
else
    rsyncpath=$(get_rsyncpath "localhost")
    echo "--rsync-path=$rsyncpath"
fi
