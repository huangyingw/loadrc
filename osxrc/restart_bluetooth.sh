#!/bin/zsh

TIMEOUT=180

keep_connect() {
    local id="$1"
    local elapsed_time=0

    while ! blueutil --is-connected "$id" && [[ $elapsed_time -lt $TIMEOUT ]]; do
        blueutil -p 1
        blueutil --connect "$id"
        sleep 1
        ((elapsed_time++))
    done
}

ensure_power_on() {
    local elapsed_time=0

    while ! blueutil -p 1 && [[ $elapsed_time -lt $TIMEOUT ]]; do
        sleep 1
        ((elapsed_time++))
    done
}

DEVICE_ID="c8-7b-23-cd-44-ba" # Bose QC Earbuds II

blueutil -p 0
ensure_power_on
keep_connect "$DEVICE_ID" &
