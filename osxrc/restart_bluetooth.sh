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
KeepConnect 8c-85-90-f3-90-69
KeepConnect 64-a5-c3-f2-5e-00
KeepConnect 04-4b-ed-ec-2d-7b
KeepConnect 1c-1a-c0-f2-c7-31
