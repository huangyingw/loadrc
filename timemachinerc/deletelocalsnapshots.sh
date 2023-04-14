#!/bin/zsh

# This script deletes local Time Machine snapshots on macOS

# Get the list of local snapshots for the root directory
snapshot_list=$(tmutil listlocalsnapshots / 2>/dev/null)

# Check if there are any snapshots to delete
if [ -z "$snapshot_list" ]; then
    echo "No local snapshots found."
    exit 0
fi

# Extract snapshot dates using a regex pattern
snapshot_dates=$(echo "$snapshot_list" | grep -oE '\w{4}-\w{2}-[0-9]{2}-[0-9]{6}')

# Delete each snapshot one by one
if [ -n "$snapshot_dates" ]; then
    echo "Deleting local snapshots..."
    while read -r snapshot_date; do
        if sudo tmutil deletelocalsnapshots "$snapshot_date" 2>/dev/null; then
            echo "Deleted snapshot: $snapshot_date"
        else
            echo "Error deleting snapshot: $snapshot_date"
        fi
    done <<< "$snapshot_dates"
    echo "Local snapshots deleted successfully."
else
    echo "No local snapshots found."
fi
