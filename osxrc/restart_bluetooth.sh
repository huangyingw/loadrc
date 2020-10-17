#!/bin/zsh
KeepConnect() {
    ID="$1"
    while [[ $(blueutil --is-connected "$ID") != 1 ]]
    do
        blueutil -p 1
        blueutil --connect "$ID"
    done
}

blueutil -p 0

while [[ $(blueutil -p) != 1 ]]
do
    blueutil -p 1
done

KeepConnect 74-1a-e0-20-d3-b7 & # nuraphone 608
KeepConnect 64-a5-c3-f2-5e-00 & # Ying Huang’s Trackpad II
KeepConnect 8c-85-90-f3-90-69 & # Magic Trackpad 2
