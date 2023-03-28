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

KeepConnect c8-7b-23-cd-44-ba & # Bose QC Earbuds II
