#!/bin/bash -
function upsearch () {
    test / == "$PWD" && return || test -e "$1" && return || cd .. && upsearch "$1"
}

DIR=$(dirname "$1")
cd "$DIR"
upsearch .git
if [ -f .git ]
then
    relative=$(cat .git | awk '{print $2}')
    echo "$(realpath $relative/index)"
else
    echo "$(realpath .git/index)"
fi
