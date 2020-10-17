#!/bin/zsh
function upsearch () {
    test / = "$pwd" && return || test -e "$1" && return || cd .. && upsearch "$1"
}

upsearch "$1"
