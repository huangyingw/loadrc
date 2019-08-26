#!/bin/bash -
KeepConnect() {
    ID="$1"
    while [[ $(blueutil --is-connected "$ID") != 1 ]]
    do
        blueutil --connect "$ID"
    done
}

blueutil -p 0

while [[ $(blueutil -p) != 1 ]]
do
    blueutil -p 1
done

KeepConnect 74-1a-e0-20-d3-b7
KeepConnect 80-4a-14-71-28-8c
KeepConnect 64-a5-c3-f2-5e-00
KeepConnect 8c-85-90-f3-90-69
