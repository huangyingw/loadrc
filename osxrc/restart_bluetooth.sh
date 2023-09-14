#!/bin/zsh

TIMEOUT=2

# Function to keep the Bluetooth connection alive
keep_connect() {
    local id="$1"
    local elapsed_time=0

    while [[ $(blueutil --is-connected "$id") != 1 ]] && [[ $elapsed_time -lt $TIMEOUT ]]; do
        blueutil -p 1
        blueutil --connect "$id"
        sleep 1
        ((elapsed_time++))
    done
}

# Function to ensure Bluetooth is powered on
ensure_power_on() {
    local elapsed_time=0

    while ! blueutil -p 1 && [[ $elapsed_time -lt $TIMEOUT ]]; do
        sleep 1
        ((elapsed_time++))
    done
}

# Array of device IDs
DEVICE_IDS=("c8-7b-23-cd-44-ba" "ac-bf-71-46-77-65")  # Black Bose QC Earbuds II and Blue Bose QC Earbuds II

# Turn off Bluetooth
blueutil -p 0

# Ensure Bluetooth is powered on
ensure_power_on

# Connect to all devices in parallel
for id in "${DEVICE_IDS[@]}"; do
    keep_connect "$id" &
done

# Wait for all background tasks to complete
wait
